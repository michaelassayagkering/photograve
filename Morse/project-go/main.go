package main

import (
	"fmt"
	"os"
)

func main() {
	// Retrieve input args only.
	argsWithoutProg := os.Args[1:]

	// Retrieve options and string to convert.
	opts, data := getOptions(argsWithoutProg)

	// Check data.
	if len(data) <= 0 {
		exitOnError("Empty data")
	}

	// Morse computation.
	var out = "failure"
	if opts.mode {
		out = demorse(data)
	} else {
		out = morse(data)
	}

	// Copy to MacOS pastboard.
	if opts.pastboard {
		writeAll(out)
	}
	// Output result.
	if opts.verbose {
		fmt.Println("\n\nResult:\n\n\"" + out + "\"\n\n")
	} else {
		fmt.Println(out)
	}
}
