//
//  Morse.m
//  morse
//
//  Created by Gabriel Bremond on 12/11/2013.
//  Copyright (c) 2013 Gabriel Bremond. All rights reserved.
//

#import "Morse.h"

@implementation Morse


/* Morse standard characters.
 @see: http://en.wikipedia.org/wiki/Morse_code
 
 'E", ".",
 'T", "-",
 ' ", "/"

 'A", ".-",
 'I", "..",
 'M", "--",
 'N", "-.",
 
 'D", "-..",
 'G", "--.",
 'K", "-.-",
 'O", "---",
 'R", ".-.",
 'S", "...",
 'U", "..-",
 'W", ".--",

 'B", "-...",
 'C", "-.-.",
 'F", "..-.",
 'H", "....",
 'J", ".---",
 'L", ".-..",
 'P", ".--.",
 'Q", "--.-",
 'V", "...-",
 'X", "-..-",
 'Y", "-.--",
 'Z", "--..",
 '<AA>".-.-',

 '1", ".----",
 '2", "..---",
 '3", "...--",
 '4", "....-",
 '5", ".....",
 '6", "-....",
 '7", "--...",
 '8", "---..",
 '9", "----.",
 '0", "-----",
 '/", "-..-.",
 '=", "-...-",
 '+".-.-.',
 '&".-...',
 '<BT>"-...-',
 '<TV>"-...-',
 '<CT>"-.-.-',
 '<KN>"-.--.',
 '<SN>"...-.',
 '<VE>"...-.',
 
 '.", ".-.-.-",
 ',", "--..--",
 ":", "---...",
 '?", "..--..",
 '\'", ".----.",
 '-", "-....-",
 '(", "-.--.",
 ')", "-.--.-",
 '"", ".-..-.",
 '@", ".--.-.",
 '<DO>"-..---',
 '<SK>"...-.-',
 '<VA>"...-.-',
 '!'-.-.--,
 
 '<BK>"-...-.-',
 
 '<CL>"-.-..-..',
 
 '<SOS>"...---...'

 */


+ (NSArray *)chars
{
    return @[
            // 1 morse char.
            @"E", @"T",
            // 2 morse char.
            @"A", @"I", @"M", @"N",
            // 3 morse char.
            @"D", @"G", @"K", @"O", @"R", @"S", @"U", @"W",
            // 4 morse char.
            @"B", @"C", @"F", @"H", @"J", @"L", @"P", @"Q", @"V", @"X", @"Y", @"Z", @"<AA>",
            // 5 morse char.
            @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"/", @"=", @"+", @"&", @"<BT>", @"<TV>", @"<CT>", @"<KN>", @"<SN>", @"<VE>", @"(", @"À", @"Ç", @"È", @"É",
            // 6 morse char.
            @".", @",", @":", @"?", @"'", @"-", @")", @"\"", @"@", @"<DO>", @"<SK>", @"<VA>", @"!", @";", @"_",
            // 7 morse char.
            @"<BK>",@"$",
            // 8 morse char.
            @"<CL>",
            // 9 morse char.
            @"<SOS>"
            ];
}

+ (NSArray *)morsechars
{
    return @[
            // 1 morse char.
            @".", @"-",
            // 2 morse char.
            @".-", @"..", @"--", @"-.",
            // 3 morse char.
            @"-..", @"--.", @"-.-", @"---", @".-.", @"...", @"..-", @".--",
            // 4 morse char.
            @"-...", @"-.-.", @"..-.", @"....", @".---", @".-..", @".--.", @"--.-", @"...-", @"-..-", @"-.--", @"--..", @".-.-",
            // 5 morse char.
            @".----", @"..---", @"...--", @"....-", @".....", @"-....", @"--...", @"---..", @"----.", @"-----", @"-..-.", @"-...-", @".-.-.", @".-...", @"-...-", @"-...-", @"-.-.-", @"-.--.", @"...-.", @"...-.", @"-.--.", @".--.-", @"-.-..", @".-..-", @"..-..",
            // 6 morse char.
            @".-.-.-", @"--..--", @"---...", @"..--..", @".----.", @"-....-", @"-.--.-", @".-..-.", @".--.-.", @"-..---", @"...-.-", @"...-.-",@"-.-.--",@"-.-.-.",@"..--.-",
            // 7 morse char.
            @"-...-.-",@"...-..-",
            // 8 morse char.
            @"-.-..-..",
            // 9 morse char.
            @"...---..."
            ];
}

// Encode into Morse language.
+ (NSString *)morse:(NSString *)data
{
    if (data==NULL || data.length==0)
    {
        return NULL;
    }
    
    // Make all charaters upper.
    NSString *toTranslate = [data uppercaseString];

    // Replace unsecable spaces.
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@" " withString:@" "];
    
    // Replace '.' and '-'
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"." withString:@"|.|"];
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"-" withString:@"|-|"];
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"|.|" withString:@".-.-.- "];
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"|-|" withString:@"-....- "];
    
    // Convert all other characters.
    NSArray *chars = [Morse chars];
    NSArray *morsechars = [Morse morsechars];
    for (int i = (int)chars.count - 1; i >= 0; i--)
    {
        if ([[chars objectAtIndex:i] isEqualToString:@"."])
        {
            continue;
        }
        if ([[chars objectAtIndex:i] isEqualToString:@"-"])
        {
            continue;
        }
        
        toTranslate = [toTranslate stringByReplacingOccurrencesOfString:[chars objectAtIndex:i] withString:[[morsechars objectAtIndex:i] stringByAppendingString:@" "]];
     }
    
    return toTranslate;
}

// Decode from Morse language.
+ (NSString *)demorse:(NSString *)data
{
    if (data==NULL || data.length==0)
    {
        return NULL;
    }
    
    // Make all charaters upper.
    NSString *toTranslate = [data uppercaseString];
    
    // Replace unsecable spaces.
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@" " withString:@" "];

    // Replace '.' and '-'
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@".-.-.- " withString:@"|.|"];
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"-....- " withString:@"|-|"];

    // Convert all other characters.
    NSArray *chars = [Morse chars];
    NSArray *morsechars = [Morse morsechars];
    for (int i = (int)chars.count - 1; i >= 0; i--)
    {
        if ([[chars objectAtIndex:i] isEqualToString:@"."])
        {
            continue;
        }
        if ([[chars objectAtIndex:i] isEqualToString:@"-"])
        {
            continue;
        }
        
        toTranslate = [toTranslate stringByReplacingOccurrencesOfString:[[morsechars objectAtIndex:i] stringByAppendingString:@" "] withString:[chars objectAtIndex:i]];
    }
    
    // Replace '.' and '-'
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"|.|" withString:@"."];
    toTranslate = [toTranslate stringByReplacingOccurrencesOfString:@"|-|" withString:@"-"];
    
    return toTranslate;
}

@end
