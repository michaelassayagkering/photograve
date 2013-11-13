//
//  Morse.h
//  morse
//
//  Created by Gabriel Bremond on 12/11/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class Morse
 @abstract Morse class.
 @discussion This class is in charge of encoding/decoding data from/to morse.
 */
@interface Morse : NSObject

/*!
 @method morse:
 @abstract Encode into Morse language.
 @param data : The string to encode.
 @return the encoded string, NULL otherwise.
 */
+ (NSString *)morse:(NSString *)data;

/*!
 @method demorse:
 @abstract Decode from Morse language.
 @param data : The string to decode.
 @return the decoded string, NULL otherwise.
 */
+ (NSString *)demorse:(NSString *)data;

@end
