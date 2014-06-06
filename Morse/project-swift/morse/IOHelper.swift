//
//  IOHelper.swift
//  morse
//
//  Created by Gabriel Bremond on 05/06/14.
//  Copyright (c) 2014 photograve. All rights reserved.
//

import Foundation

enum MorseOptions {
    
    case Mode
    case Verbose
    case Pastboard
}

class IOHelper {
    
    class func lookForData() -> (String, MorseOptions[]) {
        
        var opts = MorseOptions[]()
        var lastOption = 0
        
        var arg: String
        var number: Int = 0
        for i in 0..C_ARGC
        {
            let index = Int(i)
            arg = String.fromCString(C_ARGV[index])
 
            if arg == "--usage" || arg == "-help" || arg == "-h"
            {
                IOHelper.printHelp()
            }
            else if arg == "--version"
            {
                IOHelper.printVersion()
            }
            else if arg.hasPrefix("-")
            {
                for char: Character in arg
                {
                    if String(char) == "d"
                    {
                        opts.append(MorseOptions.Mode)
                        lastOption = Int(i)
                    }
                    else if String(char) == "v"
                    {
                        opts.append(MorseOptions.Verbose)
                        lastOption = Int(i)
                    }
                    else if String(char) == "c"
                    {
                        opts.append(MorseOptions.Pastboard)
                        lastOption = Int(i)
                    }
                }
            }
            
            number = Int(i)
        }

        // Check ranges
        let lastIndex = Int(lastOption + 1)
        if number < lastIndex
        {
            IOHelper.exitOnError("Empty data")
        }
        
        // Look for a content.
        var content = C_ARGV[lastIndex]
        if content.hashValue == nil
        {
            IOHelper.exitOnError("Empty data")
        }

        // Last option cannot be empty.
        arg = String.fromCString(content)
        if arg.isEmpty
        {
            IOHelper.exitOnError("Empty data")
        }
        
        return (arg, opts)
    }
    
    class func exitOnError(message: String)
    {
        println("")
        println("\(message)")
        println("Use: 'morse -h' for help.")
        println("")

        exit(-1)
    }
    
    class func printHelp()
    {
        println("")
        println("Morse ©photograve 2013.")
        println("This is a MacOSX command line.")
        println("")
        println("Use input parameters:")
        println("    -d    to decode a Morse string (optional).")
        println("    -v    Verbose mode (optional).")
        println("    -c    Copy result into the general pastboard (optional).")
        println("")
        println("morse [-dvc] \"My string here\"")
        println("")
        println("--version          Get the program version.")
        println("")
        println("--usage | -help    To get this help.")
        println("")
        
        exit(-1)
    }
    
    class func printVersion()
    {
        println("")
        println("Morse CLI:")
        println("Version 1.3")
        println("")
        
        exit(-1)
    }
}
