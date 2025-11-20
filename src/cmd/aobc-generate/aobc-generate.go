// SPDX-License-Identifier: BSD-2-Clause
//
// Copyright (c) 2025 The FreeBSD Foundation
//
// This software was developed by Pierre Pronchery <pierre@defora.net> at Defora
// Networks GmbH under sponsorship from the FreeBSD Foundation.

package main

import (
	"bytes"
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"gopkg.in/yaml.v3"
)

type tuple struct {
	key   string
	value string
}

const (
	databaseFilename     string = "database.yml"
	dependenciesFilename string = "dependencies.md"
	planFilename         string = "plan.md"
	progname             string = "aobc-generate"
	sectionIgnore        string = "Internal"
	securityFilename     string = "security.md"
)

func aobcGenerate() error {
	var err error
	var root yaml.Node

	data, err := ioutil.ReadFile(databaseFilename)
	if err != nil {
		return err
	}

	dec := yaml.NewDecoder(bytes.NewReader(data))
	dec.KnownFields(false)
	if err = dec.Decode(&root); err != nil {
		return err
	}

	//validate the input
	if len(root.Content) == 0 {
		err = errors.New("invalid input (empty file)")
		return err
	}

	err = aobcGenerateDependencies(dec, root)
	if err == nil {
		err = aobcGeneratePlan(dec, root)
	}
	if err == nil {
		err = aobcGenerateSecurityReview(dec, root)
	}
	if err == nil {
		err = aobcGeneratePkgConfig(dec, root)
	}
	return err
}

func aobcGenerateDependencies(dec *yaml.Decoder, root yaml.Node) error {
	var err error
	var ofile *os.File

	if ofile, err = os.Create(dependenciesFilename); err != nil {
		return err
	}
	defer ofile.Close()

	top := root.Content[0]

	//obtain the columns
	columns := databaseGetColumns(root, "DependenciesColumns")

	//output the table header
	reportHeader(ofile, columns)

	//output the entries
	switch top.Kind {
	case yaml.MappingNode:
		for i := 0; i < len(top.Content); i += 2 {
			if top.Content[i].Value != "Sections" {
				continue
			}
			section := top.Content[i+1]
			for _, v := range section.Content {
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						if v.Content[k+1].Kind == yaml.ScalarNode {
							//new section
							if v.Content[k].Value == sectionIgnore {
								break
							}
							fmt.Fprintf(ofile, "| __%s__", textEscape(v.Content[k].Value))
							for range columns {
								fmt.Fprintf(ofile, " |")
							}
							fmt.Fprintf(ofile, "\n")
						} else if v.Content[k+1].Kind == yaml.SequenceNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								for _, entry := range v.Content[k+1].Content {
									if entry.Kind == yaml.MappingNode {
										for m := 0; m < len(entry.Content); m += 2 {
											//special case: directory
											if col.key == "directory" &&
												entry.Content[m].Value == col.key {
												if entry.Content[m+1].Kind == yaml.SequenceNode {
													var str []string

													for _, w := range entry.Content[m+1].Content {
														str = append(str, w.Value)
													}
													values[col.key] = "`" + strings.Join(str, "`, `") + "`"
													break
												}
												values[col.key] = "`" + entry.Content[m+1].Value + "`"
												break
											} else if entry.Content[m].Value == col.key {
												//general case
												values[col.key] = entry.Content[m+1].Value
												break
											}
										}
									}
								}
							}
							reportRow(ofile, columns, values)
						}
					}
				}
			}
		}
	}

	return nil
}

func aobcGeneratePkgConfig(dec *yaml.Decoder, root yaml.Node) error {
	var err error
	var prefix, filename string
	var ofile *os.File

	if err = os.MkdirAll("pkgconfig", 0755); err != nil {
		return err
	}

	top := root.Content[0]

	//obtain the columns
	columns := databaseGetColumns(root, "PkgConfigColumns")

	//output the files
	switch top.Kind {
	case yaml.MappingNode:
		for i := 0; i < len(top.Content); i += 2 {
			if top.Content[i].Value != "Sections" {
				continue
			}
			section := top.Content[i+1]
			for _, v := range section.Content {
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						if v.Content[k+1].Kind == yaml.ScalarNode {
							//new section
							if v.Content[k].Value == sectionIgnore {
								prefix = "FreeBSD-"
							} else {
								prefix = ""
							}
						} else if v.Content[k+1].Kind == yaml.SequenceNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value

							filename = "pkgconfig/" + prefix + values["title"] + ".pc"
							filename = strings.ReplaceAll(filename, " ", "-")

							if ofile, err = os.Create(filename); err != nil {
								return err
							}
							defer ofile.Close()

							for _, col := range columns {
								for _, entry := range v.Content[k+1].Content {
									if entry.Kind == yaml.MappingNode {
										for m := 0; m < len(entry.Content); m += 2 {
											//special cases: depends, owners
											if (col.key == "depends" || col.key == "owners") &&
												entry.Content[m].Value == col.key &&
												entry.Content[m+1].Kind == yaml.SequenceNode {
												var str []string

												for _, w := range entry.Content[m+1].Content {
													str = append(str, w.Value)
												}
												values[col.key] = strings.Join(str, ", ")
											} else if entry.Content[m].Value == col.key {
												values[col.key] = entry.Content[m+1].Value
												break
											}
										}
									}
								}
							}
							for _, col := range columns {
								if len(values[col.key]) > 0 {
									fmt.Fprintf(ofile, "%s: %s\n", textEscape(col.value),
										textEscape(values[col.key]))
								} else if col.key == "description" || col.key == "version" {
									fmt.Fprintf(ofile, "%s:\n", textEscape(col.value))
								}
							}
						}
					}
				}
			}
		}
	}
	return nil
}

func aobcGeneratePlan(dec *yaml.Decoder, root yaml.Node) error {
	var err error
	var ofile *os.File

	if ofile, err = os.Create(planFilename); err != nil {
		return err
	}
	defer ofile.Close()

	top := root.Content[0]

	//obtain the columns
	columns := databaseGetColumns(root, "PlanColumns")

	//output the table header
	reportHeader(ofile, columns)

	//output the entries
	switch top.Kind {
	case yaml.MappingNode:
		for i := 0; i < len(top.Content); i += 2 {
			if top.Content[i].Value != "Sections" {
				continue
			}
			section := top.Content[i+1]
			for _, v := range section.Content {
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						if v.Content[k+1].Kind == yaml.ScalarNode {
							//new section
							if v.Content[k].Value == sectionIgnore {
								break
							}
							fmt.Fprintf(ofile, "| __%s__", textEscape(v.Content[k].Value))
							for range columns {
								fmt.Fprintf(ofile, " |")
							}
							fmt.Fprintf(ofile, "\n")
						} else if v.Content[k+1].Kind == yaml.SequenceNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								for _, entry := range v.Content[k+1].Content {
									if entry.Kind == yaml.MappingNode {
										for m := 0; m < len(entry.Content); m += 2 {
											if entry.Content[m].Value == col.key {
												//general case
												values[col.key] = entry.Content[m+1].Value
												break
											}
										}
									}
								}
							}
							reportRow(ofile, columns, values)
						}
					}
				}
			}
		}
	}

	return nil
}

func aobcGenerateSecurityReview(dec *yaml.Decoder, root yaml.Node) error {
	var err error
	var ofile *os.File

	if ofile, err = os.Create(securityFilename); err != nil {
		return err
	}
	defer ofile.Close()

	top := root.Content[0]

	//obtain the columns
	columns := databaseGetColumns(root, "SecurityColumns")

	//output the table header
	reportHeader(ofile, columns)

	//output the entries
	switch top.Kind {
	case yaml.MappingNode:
		for i := 0; i < len(top.Content); i += 2 {
			if top.Content[i].Value != "Sections" {
				continue
			}
			section := top.Content[i+1]
			for _, v := range section.Content {
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						if v.Content[k+1].Kind == yaml.ScalarNode {
							//new section
							if v.Content[k].Value == sectionIgnore {
								break
							}
							fmt.Fprintf(ofile, "| __%s__", textEscape(v.Content[k].Value))
							for range columns {
								fmt.Fprintf(ofile, " |")
							}
							fmt.Fprintf(ofile, "\n")
						} else if v.Content[k+1].Kind == yaml.SequenceNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								for _, entry := range v.Content[k+1].Content {
									if entry.Kind == yaml.MappingNode {
										for m := 0; m < len(entry.Content); m += 2 {
											//special case: security
											if col.key == "security" &&
												entry.Content[m].Value == col.key {
												if entry.Content[m+1].Kind == yaml.SequenceNode {
													var str []string

													for _, w := range entry.Content[m+1].Content {
														str = append(str, w.Value)
													}
													values[col.key] = strings.Join(str, ", ")
													values["score"] = fmt.Sprintf("%d", len(str))
													break
												}
												values[col.key] = entry.Content[m+1].Value
												values["score"] = fmt.Sprintf("%d", 1)
												break
											} else if entry.Content[m].Value == col.key {
												//general case
												values[col.key] = entry.Content[m+1].Value
												break
											}
										}
									}
								}
							}
							reportRow(ofile, columns, values)
						}
					}
				}
			}
		}
	}

	return nil
}

func databaseGetColumns(root yaml.Node, label string) []tuple {
	var columns []tuple

	top := root.Content[0]

	switch top.Kind {
	case yaml.MappingNode:
		for i := 0; i < len(top.Content); i += 2 {
			if top.Content[i].Value != label {
				continue
			}
			column := top.Content[i+1]
			for _, v := range column.Content {
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						columns = append(columns, tuple{v.Content[k].Value,
							v.Content[k+1].Value})
					}
				}
			}
		}
	}
	return columns
}

func reportHeader(ofile *os.File, columns []tuple) {
	for _, title := range columns {
		fmt.Fprintf(ofile, "| %s ", textEscape(title.value))
	}
	fmt.Fprintf(ofile, "|\n")
	for range columns {
		fmt.Fprintf(ofile, "| --- ")
	}
	fmt.Fprintf(ofile, "|\n")
}

func reportRow(ofile *os.File, columns []tuple, values map[string]string) {
	for _, col := range columns {
		fmt.Fprintf(ofile, "| %s ", textEscape(values[col.key]))
	}
	fmt.Fprintf(ofile, "|\n")
}

func textEscape(text string) string {
	text = strings.ReplaceAll(text, `\`, `\\`)
	text = strings.ReplaceAll(text, "_", `\_`)
	text = strings.ReplaceAll(text, "|", `\|`)
	text = strings.ReplaceAll(text, "\r\n", "\n")
	text = strings.ReplaceAll(text, "\n", "<br>")
	return text
}

func usage() int {
	fmt.Fprintf(os.Stderr, `Usage: %s`, progname)
	return 1
}

func main() {
	var err error

	flag.Parse()
	if len(flag.Args()) != 0 {
		os.Exit(usage())
	}

	if err = aobcGenerate(); err != nil {
		fmt.Fprintf(os.Stderr, "%s: %s\n", progname, err)
		os.Exit(2)
	}

	os.Exit(0)
}
