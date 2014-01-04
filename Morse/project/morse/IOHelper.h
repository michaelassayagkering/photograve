//
//  IOHelper.h
//  morse
//
//  Created by Gabriel Bremond on 15/12/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    MorseOptionMode        = 1 << 0,
    MorseOptionVerbose     = 1 << 1,
    MorseOptionPastboard   = 1 << 2
};
typedef NSUInteger MorseOptions;

/*!
 @class IOHelper
 @abstract Data and options grabber helper.
 @discussion Retrieve string data and options from the program inputs.
 */
@interface IOHelper : NSObject

/*!
 @method lookForData:fromArgs:
 @abstract Search for data in given arguments.
 @param[in] data    :   Found string to convert.
 @param     argv[]  :   Program arguments.
 @returns Found options @see MorseOptions
 */
+ (MorseOptions)lookForData:(NSString **)data fromArgs:(const char *[])argv;

/*!
 @method exitOnError:
 @abstract Exit the programdisplaying the error message and invite user to use the help option.
 @param message :   The message to display.
 */
+ (void)exitOnError:(NSString *)message;

@end
