photograve
==========

All my small projects.
==========
Morse
==========

A small command line Morse converter for MacOSX.  
Features:  
• Encode a string into Morse.  
• Decode a Morse string.  
• Verbose or pipeline output mode.  
• Pastboard auto copy option.  

----------

Changes :

v1.1
- Treat non-standard points and dash characters.

v1.2
- Refactor input/output treatments.

v1.3
- Rewrite the project into Swift.

v1.4
- Move to OSX 10.10
- Build with Swift 2.0

v1.5
- Move to OSX 10.13
- Build with Swift 4.0
- Make Go version

----------

Binary size:
1. Objective-C version with 30kb
2. Go version with 2.1Mb
3. Swift version with 4.4Mb

----------

Speed tests:

using command:

`$ time ./morse[|swift|go] "[A huge text]" > dev/nul`


 Restults:      | Real  | User  | Sys   
 -------------- | ----- | ----- | ----- 
 1/ Go          |  6ms  |  2ms  |  3ms  
 2/ Objective-C | 20ms  | 10ms  |  5ms  
 3/ Swift       | 22ms  | 12ms  |  6ms  


