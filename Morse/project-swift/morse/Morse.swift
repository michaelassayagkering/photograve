//
//  Morse.swift
//  Morse
//
//  Created by Gabriel Bremond on 06/06/14.
//  Copyright (c) 2014 photograve. All rights reserved.
//

import Foundation

class Morse {
    
    
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
    '", ".--.-.",
    '<DO>"-..---',
    '<SK>"...-.-',
    '<VA>"...-.-',
    '!'-.-.--,
    
    '<BK>"-...-.-',
    
    '<CL>"-.-..-..',
    
    '<SOS>"...---...'
    
    */
    
    
    class func chars() -> Array<String> {
        
        return [
            // 1 morse char.
            "E", "T",
            // 2 morse char.
            "A", "I", "M", "N",
            // 3 morse char.
            "D", "G", "K", "O", "R", "S", "U", "W",
            // 4 morse char.
            "B", "C", "F", "H", "J", "L", "P", "Q", "V", "X", "Y", "Z", "<AA>",
            // 5 morse char.
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "/", "=", "+", "&", "<BT>", "<TV>", "<CT>", "<KN>", "<SN>", "<VE>", "(", "À", "Ç", "È", "É",
            // 6 morse char.
            ".", ",", ":", "?", "'", "-", ")", "\"", "", "<DO>", "<SK>", "<VA>", "!", ";", "_",
            // 7 morse char.
            "<BK>","$",
            // 8 morse char.
            "<CL>",
            // 9 morse char.
            "<SOS>"
        ]
    }
    
    class func morsechars() -> [String] {

        return [
            // 1 morse char.
            ".", "-",
            // 2 morse char.
            ".-", "..", "--", "-.",
            // 3 morse char.
            "-..", "--.", "-.-", "---", ".-.", "...", "..-", ".--",
            // 4 morse char.
            "-...", "-.-.", "..-.", "....", ".---", ".-..", ".--.", "--.-", "...-", "-..-", "-.--", "--..", ".-.-",
            // 5 morse char.
            ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.", "-----", "-..-.", "-...-", ".-.-.", ".-...", "-...-", "-...-", "-.-.-", "-.--.", "...-.", "...-.", "-.--.", ".--.-", "-.-..", ".-..-", "..-..",
            // 6 morse char.
            ".-.-.-", "--..--", "---...", "..--..", ".----.", "-....-", "-.--.-", ".-..-.", ".--.-.", "-..---", "...-.-", "...-.-","-.-.--","-.-.-.","..--.-",
            // 7 morse char.
            "-...-.-","...-..-",
            // 8 morse char.
            "-.-..-..",
            // 9 morse char.
            "...---..."
        ]
    }
    
    // Replace non-standard characters by standard.
    class func replaceIllegalCharacters(_ toReplace: String) -> String {
        
        var replaced: NSString = toReplace as NSString

        // Replace unsecable spaces.
        replaced = replaced.replacingOccurrences(of: " ", with:" ") as NSString
        
        // Replace strange point.
        replaced = replaced.replacingOccurrences(of: "·", with:".") as NSString
        replaced = replaced.replacingOccurrences(of: "•", with:".") as NSString
        
        // Replace long dash by standard dash.
        replaced = replaced.replacingOccurrences(of: "−", with:"−") as NSString
        replaced = replaced.replacingOccurrences(of: "−", with:"-") as NSString
        
        return replaced as String
    }

    // Encode into Morse language.
    class func morse(_ data: String) -> String
    {
        if data.isEmpty
        {
            return ""
        }
        
        // Make all charaters upper.
        var toTranslate = data.uppercased()
        
        // Replace illegal characters.
        toTranslate = Morse.replaceIllegalCharacters(toTranslate)
        
        // Replace '.' and '-'
        toTranslate = toTranslate.replacingOccurrences(of: ".", with:"|.|")
        toTranslate = toTranslate.replacingOccurrences(of: "-", with:"|-|")
        toTranslate = toTranslate.replacingOccurrences(of: "|.|", with:".-.-.- ")
        toTranslate = toTranslate.replacingOccurrences(of: "|-|", with:"-....- ")
        
        // Convert all other characters.
        let chars = Morse.chars()
        let morsechars = Morse.morsechars()
        
        let i = chars.count - 1
        for index in (0...i).reversed()
        {
            if chars[index] == "."
            {
                continue
            }
            if chars[index] == "-"
            {
                continue
            }
            
            let morsechar = morsechars[index] + " "
            toTranslate = toTranslate.replacingOccurrences(of: chars[index] , with: morsechar)
        }
        
        return toTranslate
    }

    // Decode from Morse language.
    class func demorse(_ data: String) -> String
    {
        if data.isEmpty
        {
            return ""
        }
        
        // Make all charaters upper.
        var toTranslate = data.uppercased()
        
        // Replace illegal characters.
        toTranslate = Morse.replaceIllegalCharacters(toTranslate)
        
        // Add end space.
        toTranslate = toTranslate + " "
        
        // Replace '.' and '-'
        toTranslate = toTranslate.replacingOccurrences(of: ".-.-.- ", with:"|.|")
        toTranslate = toTranslate.replacingOccurrences(of: "-....- ", with:"|-|")
        
        // Convert all other characters.
        let chars = Morse.chars()
        let morsechars = Morse.morsechars()
        let i = chars.count - 1
        for index in (0...i).reversed()
        {
            if chars[index] == "."
            {
                continue
            }
            if chars[index] == "-"
            {
                continue
            }
            
            let morsechar = morsechars[index] + " "
            toTranslate = toTranslate.replacingOccurrences(of: morsechar , with: chars[index])
        }
        
        // Replace '.' and '-'
        toTranslate = toTranslate.replacingOccurrences(of: "|.|", with:".")
        toTranslate = toTranslate.replacingOccurrences(of: "|-|", with:"-")
        
        return toTranslate
    }
}
