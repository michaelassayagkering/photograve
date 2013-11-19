//
//  main.m
//  morse
//
//  Created by Gabriel Bremond on 12/11/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Morse.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        BOOL verbose = NO;
        BOOL demorse = NO;
        BOOL pastboard = NO;
        NSString *data = NULL;
        
        int lastOption = 0;
    
        @try
        {
            for (int i=0; i < sizeof(&argv); i++)
            {
                if (argv[i] == nil)
                {
                    continue;
                }
                
                NSString *arg = [NSString stringWithUTF8String:argv[i]];
                if (([arg isEqualToString:@"--usage"] == YES) || ([arg isEqualToString:@"-help"] == YES))
                {
                    printf("\n\r");
                    printf("Morse ©photograve 2013.\n\r");
                    printf("This is a MacOSX command line.\n\r");
                    printf("\n\r");
                    printf("Use input parameters: \n\r");
                    printf("    -d    to decode a Morse string (optional).\n\r");
                    printf("    -v    Verbose mode (optional).\n\r");
                    printf("    -c    Copy result into the general pastboard.");
                    printf("\n\r");
                    printf("morse [-dvc] \"My string here\"\n\r");
                    printf("\n\r");
                    printf("--version          Get the program version.");
                    printf("\n\r");
                    printf("--usage | -help    To get this help.\n\r");
                    printf("\n\r");
                    exit(-1);
                }
                else if ([arg isEqualToString:@"--version"] == YES)
                {
                    printf("\n\r");
                    printf("Morse CLI: \n\r");
                    printf("Version 1.1\n\r");
                    printf("\n\r");
                    exit(-1);
                }
                else if ([arg characterAtIndex:0] == '-')
                {
                    for (int j=0; j<arg.length; j++)
                    {
                        if ([arg characterAtIndex:j] == 'd')
                        {
                            demorse = YES;
                            lastOption = i;
                        }
                        if ([arg characterAtIndex:j] == 'v')
                        {
                            verbose = YES;
                            lastOption = i;
                        }
                        if ([arg characterAtIndex:j] == 'c')
                        {
                            pastboard = YES;
                            lastOption = i;
                        }
                   }
                }
            }
        }
        @catch (NSException *exception)
        {
        }
        
        // Check if a data has been detected.
        if (sizeof(&argv) <= lastOption)
        {
            printf("Empty data\n\r");
            exit(-1);
        }
        
        @try
        {
            data = [NSString stringWithUTF8String:argv[lastOption + 1]];
        }
        @catch (NSException *exception)
        {
        }
        
        // Check data.
        if (data==NULL || data.length==0)
        {
            printf("Empty data\n\r");
            exit(-1);
        }
        
        // Morse computation.
        NSString *output = @"failure";
        @try
        {
            if (demorse)
            {
                output = [Morse demorse:data];
            }
            else
            {
                output = [Morse morse:data];
            }
        }
        @catch (NSException *exception)
        {
            output = @"failure";
        }
        
        // Copy to MacOS pastboard.
        if (pastboard)
        {
            NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
            [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
            [pasteBoard setString:output forType:NSStringPboardType];
        }
        
        // Output result.
        if (verbose == YES)
        {
            printf("\n\nResult:\n\n\"%s\"\n\n",[output UTF8String]);
        }
        else
        {
            printf("\"%s\"",[output UTF8String]);
        }
    }
    
    return 0;
}

