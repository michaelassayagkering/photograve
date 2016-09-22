//
//  IOHelper.swift
//  morse
//
//  Created by Gabriel Bremond on 05/06/14.
//  Copyright (c) 2014 photograve. All rights reserved.
//

import Foundation

enum MorseOptions {
    
    case mode
    case verbose
    case pastboard
}

class IOHelper {
    
    class func lookForData() -> (String, [MorseOptions]) {
        
        var opts = [MorseOptions]()
        var lastOption = 0
        
        var arg: String
        var number: Int = 0
        
        for i in 0...(CommandLine.arguments.count - 1)
        {
            let index = Int(i)
            arg = CommandLine.arguments[index]
 
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
                for char: Character in arg.characters
                {
                    if String(char) == "d"
                    {
                        opts.append(MorseOptions.mode)
                        lastOption = Int(i)
                    }
                    else if String(char) == "v"
                    {
                        opts.append(MorseOptions.verbose)
                        lastOption = Int(i)
                    }
                    else if String(char) == "c"
                    {
                        opts.append(MorseOptions.pastboard)
                        lastOption = Int(i)
                    }
                }
            }
            
            number = Int(i)
        }

        // Check ranges.
        let lastIndex = Int(lastOption + 1)
        if number < lastIndex
        {
            IOHelper.exitOnError("Empty data")
        }
        
        // Look for content.
        let content = CommandLine.arguments[lastIndex]
        if content.isEmpty
        {
            IOHelper.exitOnError("Empty data")
        }

        // Last option cannot be empty.
        arg = String.init(validatingUTF8:content)!
        if arg.isEmpty
        {
            IOHelper.exitOnError("Empty data")
        }
        
        return (arg, opts)
    }
    
    class func exitOnError(_ message: String)
    {
        print("")
        print("\(message)")
        print("Use: 'morse -h' for help.")
        print("")

        exit(-1)
    }
    
    class func printHelp()
    {
        print("")
        print("Morse ©photograve 2016.")
        print("http://photograve.fr")
        print("This is a macOS command line.")
        print("")
        print("Use input parameters:")
        print("    -d    to decode a Morse string (optional).")
        print("    -v    Verbose mode (optional).")
        print("    -c    Copy result into the general pastboard (optional).")
        print("")
        print("morse [-dvc] \"My string here\"")
        print("")
        print("--version          Get the program version.")
        print("")
        print("--usage | -help    To get this help.")
        print("")
        
        exit(0)
    }
    
    class func printVersion()
    {
        print("")
        print("Morse CLI:")
        print("Version 1.5")
        print("")
        
        exit(0)
    }
}
