package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"os"
	"strings"
)

var (
	progname string = "aobc-generate"
)

func aobcGenerate() error {
	return aobcGenerateDependencies()
}

func aobcGenerateDependencies() error {
	var err error
	var ifile, ofile *os.File

	if ifile, err = os.Open("dependencies.csv"); err != nil {
		return err
	}
	defer ifile.Close()

	reader := csv.NewReader(ifile)
	lines, err := reader.ReadAll()
	if err != nil {
		return err
	}

	if ofile, err = os.Create("dependencies.md"); err != nil {
		return err
	}
	defer ofile.Close()

	widths := make([]int, len(lines[0]))
	for line := range lines {
		if len(lines[line][1]) == 0 {
			w := len(lines[line][0]) + 4

			//highlight titles
			if w > widths[0] {
				widths[0] = w
			}
			continue
		}

		for i := range lines[line] {
			w := len(lines[line][i])

			if i == 1 {
				//directories
				tokens := strings.Split(lines[line][i], "|")
				w += 1 + (len(tokens)-1)*4
			}

			if w > widths[i] {
				widths[i] = w
			}
		}
	}

	for line := range lines {
		if len(lines[line][1]) == 0 {
			//print as a title
			fmt.Fprintf(ofile, "| __%s__%-*s ", textEscape(lines[line][0]), widths[0]-len(textEscape(lines[line][0]))-4, "")
			for i := range lines[line][1:] {
				fmt.Fprintf(ofile, "| %-*s ", widths[i+1], "")
			}
		} else {
			for i := range lines[line] {
				if line != 0 && i == 1 {
					tokens := strings.Split(lines[line][i], "|")
					fmt.Fprintf(ofile, "| %-*s ", widths[i], "`"+strings.Join(tokens, "`, `")+"`")
				} else {
					fmt.Fprintf(ofile, "| %-*s ", widths[i], textEscape(lines[line][i]))
				}
			}
		}
		fmt.Fprintf(ofile, "|\n")

		//print a separator line for the first line
		if line == 0 {
			separators := make([]string, len(lines[line]))
			for i := range separators {
				separators[i] = strings.Repeat("-", widths[i])
			}
			fmt.Fprintf(ofile, "| %s |\n", strings.Join(separators, " | "))
		}
	}

	return nil
}

func textEscape(text string) string {
	return strings.ReplaceAll(text, "_", "\\_")
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
