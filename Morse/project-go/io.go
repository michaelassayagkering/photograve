package main

import (
	"fmt"
	"os"
	"strings"
)

type options struct {
	mode      bool
	verbose   bool
	pastboard bool
}

func getOptions(args []string) (options, string) {

	opt := options{}
	var lastOpt = -1

	for index, arg := range args {
		// Help asked.
		if arg == "--usage" || arg == "-help" || arg == "-h" {
			printHelp()
		} else if arg == "--version" { // Look for version.
			printVersion()
		} else if strings.HasPrefix(arg, "-") {
			if strings.Contains(arg, "d") {
				opt.mode = true
				lastOpt = index
			}
			if strings.Contains(arg, "v") {
				opt.verbose = true
				lastOpt = index
			}
			if strings.Contains(arg, "c") {
				opt.pastboard = true
				lastOpt = index
			}
		}
	}

	// Check ranges.
	var lastIndex = lastOpt + 1
	number := len(args)
	if number <= lastIndex {
		exitOnError("Empty data or invalid syntax")
	}

	// Look for content.
	var content = args[lastIndex]
	if len(content) <= 0 {
		exitOnError("Empty data")
	}

	return opt, content
}

func exitOnError(message string) {
	fmt.Println("")
	fmt.Println(message)
	fmt.Println("Use: 'morse -h' for help.")
	fmt.Println("")

	os.Exit(-1)
}

func printHelp() {
	fmt.Println("")
	fmt.Println("Morse ©photograve 2017.")
	fmt.Println("https://photograve.fr")
	fmt.Println("")
	fmt.Println("This is a macOS command line.")
	fmt.Println("Use input parameters:")
	fmt.Println("    -d    to decode a Morse string (optional).")
	fmt.Println("    -v    Verbose mode (optional).")
	fmt.Println("    -c    Copy result into the general pastboard (optional).")
	fmt.Println("")
	fmt.Println("morse [-dvc] \"My string here\"")
	fmt.Println("")
	fmt.Println("--version          Get the program version.")
	fmt.Println("")
	fmt.Println("--usage | -help | -h   To get this help.")
	fmt.Println("")

	os.Exit(0)
}

func printVersion() {
	fmt.Println("")
	fmt.Println("Morse CLI:")
	fmt.Println("GO Version 1.0")
	fmt.Println("")

	os.Exit(0)
}
