//
//  IOHelper.m
//  morse
//
//  Created by Gabriel Bremond on 15/12/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import "IOHelper.h"

@implementation IOHelper

#pragma mark -
#pragma mark Public methods

// Search for data in given arguments.
+ (MorseOptions)lookForData:(NSString **)data fromArgs:(const char *[])argv
{
    MorseOptions opts = MorseOptionMode;
    int lastOption = 0;
    
    @try
    {
        NSString *arg;
        for (int i=0; i < sizeof(&argv); i++)
        {
            if (argv[i] == nil)
            {
                continue;
            }
            
            // Grab argument.
            arg = [NSString stringWithUTF8String:argv[i]];
            
            // Look for help options.
            if (([arg isEqualToString:@"--usage"] == YES) || ([arg isEqualToString:@"-help"] == YES) || ([arg isEqualToString:@"-h"] == YES))
            {
                [IOHelper printHelp];
            }
            // Look for version.
            else if ([arg isEqualToString:@"--version"] == YES)
            {
                [IOHelper printVersion];
            }
            // Tread other options.
            else if ([arg characterAtIndex:0] == '-')
            {
                for (int j=0; j<arg.length; j++)
                {
                    // Check for deciphe.
                    if ([arg characterAtIndex:j] == 'd')
                    {
                        opts ^= MorseOptionMode;
                        lastOption = i;
                    }
                    // Check verbose mode.
                    if ([arg characterAtIndex:j] == 'v')
                    {
                        opts |= MorseOptionVerbose;
                        lastOption = i;
                    }
                    // Check copy option.
                    if ([arg characterAtIndex:j] == 'c')
                    {
                        opts |= MorseOptionPastboard;
                        lastOption = i;
                    }
                }
            }
        }
    }
    @catch (NSException *exception)
    {
    }

    // Last option cannot be in an offset upper than the arguments size.
    if (sizeof(&argv) <= lastOption)
    {
        [IOHelper exitOnError:@"Empty data"];
    }
    
    // Convert data into an NSString.
    @try
    {
        *data = [NSString stringWithUTF8String:argv[lastOption + 1]];
        
        // Check data format.
        if (*data==NULL || [*data length]==0)
        {
            [[NSException exceptionWithName:@"Data error" reason:@"Failed to retrieve data." userInfo:nil] raise];
        }
    }
    @catch (NSException *exception)
    {
        [IOHelper exitOnError:@"Empty data"];
    }
    
    return opts;
}

// Exit the programdisplaying the error message and invite user to use the help option.
+ (void)exitOnError:(NSString *)message
{
    printf("%s\n\r",[message cStringUsingEncoding:NSUTF8StringEncoding]);
    printf("Use: 'morse -h' for help.\n\r");
    exit(-1);
}


#pragma mark -
#pragma mark Private methods

+ (void)printHelp
{
    printf("\n\r");
    printf("Morse ©photograve 2013.\n\r");
    printf("This is a MacOSX command line.\n\r");
    printf("\n\r");
    printf("Use input parameters: \n\r");
    printf("    -d    to decode a Morse string (optional).\n\r");
    printf("    -v    Verbose mode (optional).\n\r");
    printf("    -c    Copy result into the general pastboard (optional).");
    printf("\n\r");
    printf("morse [-dvc] \"My string here\"\n\r");
    printf("\n\r");
    printf("--version          Get the program version.");
    printf("\n\r");
    printf("--usage | -help    To get this help.\n\r");
    printf("\n\r");
    exit(-1);
}

+ (void)printVersion
{
    printf("\n\r");
    printf("Morse CLI: \n\r");
    printf("Version 1.2\n\r");
    printf("\n\r");
    exit(-1);
}

@end
