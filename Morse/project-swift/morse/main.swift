//
//  main.swift
//  morse
//
//  Created by Gabriel Bremond on 05/06/14.
//  Copyright (c) 2014 photograve. All rights reserved.
//

import Foundation
import AppKit

var data: String
var opts: MorseOptions[]

(data, opts) = IOHelper.lookForData()

// Check data.
if data.isEmpty
{
    IOHelper.exitOnError("Empty data")
}

// Morse computation.
var out = "failure"
if contains(opts, MorseOptions.Mode)
{
    out = Morse.demorse(data)
}
else
{
    out = Morse.morse(data)
}

// Copy to MacOS pastboard.
if contains(opts, MorseOptions.Pastboard)
{
    let pasteboard = NSPasteboard.generalPasteboard()
    pasteboard.declareTypes([NSStringPboardType], owner: nil)
    pasteboard.setString(out, forType: NSStringPboardType)
}

// Output result.
if contains(opts, MorseOptions.Verbose)
{
    println("\n\nResult:\n\n\"\(out)\"\n\n")
}
else
{
    println(out)
}

exit(0)