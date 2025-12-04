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
	codeownersFilename   string = "CODEOWNERS"
	databaseFilename     string = "database.yml"
	dependenciesFilename string = "dependencies.md"
	planFilename         string = "plan.md"
	progname             string = "aobc-tool"
	sectionIgnore        string = "Internal"
	securityFilename     string = "security.md"
)

func aobcBlame(path []string) error {
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

	for _, p := range path {
		if e := aobcBlamePath(dec, root, p); e != nil {
			fmt.Fprintf(os.Stderr, "%s: %s\n", progname, e)
		}
	}
	return nil
}

func aobcBlamePath(dec *yaml.Decoder, root yaml.Node, path string) error {
	var err error

	top := root.Content[0]

	//obtain the columns
	columns := [2]tuple{
		{"owner", "Owner"},
		{"directory", "Directory"},
	}

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
						} else if v.Content[k+1].Kind == yaml.MappingNode {
							var owners, directories []string
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value

							//collect the owners and paths
							for _, col := range columns {
								entry := v.Content[k+1]
								if entry.Kind == yaml.MappingNode {
									for m := 0; m < len(entry.Content); m += 2 {
										if col.key == "owner" &&
											entry.Content[m].Value == col.key {
											if entry.Content[m+1].Kind == yaml.SequenceNode {
												for _, w := range entry.Content[m+1].Content {
													owners = append(owners, w.Value)
												}
											} else if entry.Content[m+1].Kind == yaml.ScalarNode {
												owners = append(owners, entry.Content[m+1].Value)
											}
										} else if col.key == "directory" &&
											entry.Content[m].Value == col.key {
											if entry.Content[m+1].Kind == yaml.SequenceNode {
												for _, w := range entry.Content[m+1].Content {
													directories = append(directories, w.Value)
												}
											} else if entry.Content[m+1].Kind == yaml.ScalarNode {
												directories = append(directories, entry.Content[m+1].Value)
											}
										}
									}
								}
							}
							for _, v := range directories {
								if matched := strings.HasPrefix(path+"/", v+"/"); matched {
									fmt.Printf("Owner(s) for %s: (%s in %s)\n", values["title"], path, v)
									for _, v := range owners {
										fmt.Printf("- %s\n", v)
									}
									return nil
								}
							}
						}
					}
				}
			}
		}
	}

	err = fmt.Errorf("%s: no owner found", path)
	return err
}

func aobcGenerate(reports []string) error {
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

	for _, r := range reports {
		switch r {
		case "codeowners":
			err = aobcGenerateCodeOwners(dec, root)
		case "dependencies":
			err = aobcGenerateDependencies(dec, root)
		case "pkgconfig":
			err = aobcGeneratePkgConfig(dec, root)
		case "plan":
			err = aobcGeneratePlan(dec, root)
		case "securityreview":
			err = aobcGenerateSecurityReview(dec, root)
		}
		if err != nil {
			break
		}
	}

	return err
}

func aobcGenerateAll() error {
	reports := []string{"codeowners", "dependencies", "plan", "securityreview", "pkgconfig"}

	return aobcGenerate(reports)
}

func aobcGenerateCodeOwners(dec *yaml.Decoder, root yaml.Node) error {
	var err error
	var ofile *os.File

	if ofile, err = os.Create(codeownersFilename); err != nil {
		return err
	}
	defer ofile.Close()

	top := root.Content[0]

	//obtain the columns
	columns := [2]tuple{
		{"owner", "Owner"},
		{"directory", "Directory"},
	}

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
						} else if v.Content[k+1].Kind == yaml.MappingNode {
							var owners, directories []string
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value

							//collect the owners and paths
							for _, col := range columns {
								entry := v.Content[k+1]
								if entry.Kind == yaml.MappingNode {
									for m := 0; m < len(entry.Content); m += 2 {
										if col.key == "owner" &&
											entry.Content[m].Value == col.key {
											if entry.Content[m+1].Kind == yaml.SequenceNode {
												for _, w := range entry.Content[m+1].Content {
													owners = append(owners, w.Value)
												}
											} else if entry.Content[m+1].Kind == yaml.ScalarNode {
												owners = append(owners, entry.Content[m+1].Value)
											}
										} else if col.key == "directory" &&
											entry.Content[m].Value == col.key {
											if entry.Content[m+1].Kind == yaml.SequenceNode {
												for _, w := range entry.Content[m+1].Content {
													directories = append(directories, w.Value)
												}
											} else if entry.Content[m+1].Kind == yaml.ScalarNode {
												directories = append(directories, entry.Content[m+1].Value)
											}
										}
									}
								}
							}
							fmt.Fprintf(ofile, "# %s\n", values["title"])
							for _, v := range directories {
								fmt.Fprintf(ofile, "/%s", v)
								for _, v := range owners {
									if v[0] == '#' {
										fmt.Fprintf(ofile, " @FreeBSD/%s", v[1:])
									} else {
										fmt.Fprintf(ofile, " %sFreeBSD.org", v)
									}
								}
								fmt.Fprintf(ofile, "\n")
							}
							fmt.Fprintf(ofile, "\n")
						}
					}
				}
			}
		}
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
			for j := 0; j < len(section.Content); j += 2 {
				v := section.Content[j+1]
				//new section
				if section.Content[j].Value == sectionIgnore {
					continue
				}
				fmt.Fprintf(ofile, "| __%s__", textEscape(section.Content[j].Value))
				for range columns {
					fmt.Fprintf(ofile, " |")
				}
				fmt.Fprintf(ofile, "\n")
				if v.Kind == yaml.MappingNode {
					for k := 0; k < len(v.Content); k += 2 {
						if v.Content[k+1].Kind == yaml.MappingNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								entry := v.Content[k+1]
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
						} else if v.Content[k+1].Kind == yaml.MappingNode {
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
								entry := v.Content[k+1]
								if entry.Kind == yaml.MappingNode {
									for m := 0; m < len(entry.Content); m += 2 {
										//special cases: depends, owner
										if (col.key == "depends" || col.key == "owner") &&
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
						} else if v.Content[k+1].Kind == yaml.MappingNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								entry := v.Content[k+1]
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
						} else if v.Content[k+1].Kind == yaml.MappingNode {
							var values map[string]string

							//new entry
							values = make(map[string]string)
							//XXX hard-coded
							values["title"] = v.Content[k].Value
							for _, col := range columns {
								entry := v.Content[k+1]
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
			if column.Kind != yaml.MappingNode {
				continue
			}
			for j := 0; j < len(column.Content); j += 2 {
				v := column
				columns = append(columns, tuple{v.Content[j].Value,
					v.Content[j+1].Value})
			}
		}
	}
	return columns
}

func init() {
	flag.Usage = func() { usage() }
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
	fmt.Fprintf(os.Stderr, `Usage: %s generate [report]
       %s blame path...
`, progname, progname)
	return 1
}

func main() {
	var err error

	flag.Parse()
	if len(flag.Args()) < 1 {
		os.Exit(usage())
	}

	switch flag.Arg(0) {
	case "generate":
		if len(flag.Args()) == 2 {
			err = aobcGenerate(flag.Args())
		} else if len(flag.Args()) == 1 {
			err = aobcGenerateAll()
		} else {
			os.Exit(usage())
		}
		if err != nil {
			fmt.Fprintf(os.Stderr, "%s: %s\n", progname, err)
			os.Exit(2)
		}
	case "blame":
		if len(flag.Args()) < 2 {
			os.Exit(usage())
		}
		a := flag.Args()
		if err = aobcBlame(a[1:]); err != nil {
			fmt.Fprintf(os.Stderr, "%s: %s\n", progname, err)
			os.Exit(2)
		}
	default:
		if len(flag.Args()) < 1 {
			os.Exit(usage())
		}
	}

	os.Exit(0)
}
