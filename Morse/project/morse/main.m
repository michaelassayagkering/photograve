//
//  main.m
//  morse
//
//  Created by Gabriel Bremond on 12/11/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "IOHelper.h"
#import "Morse.h"

// Program entry point.
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSString *data = NULL;
        
        // Grab inputs.
        MorseOptions options = [IOHelper lookForData:&data fromArgs:argv];
        
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
            if (options & MorseOptionMode)
            {
                output = [Morse morse:data];
            }
            else
            {
                output = [Morse demorse:data];
            }
        }
        @catch (NSException *exception)
        {
            output = @"failure";
        }
        
        // Copy to MacOS pastboard.
        if (options & MorseOptionPastboard)
        {
            NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
            [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
            [pasteBoard setString:output forType:NSStringPboardType];
        }
        
        // Output result.
        if (options & MorseOptionVerbose)
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

