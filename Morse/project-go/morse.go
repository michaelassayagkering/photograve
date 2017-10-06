package main

import (
	"strings"
)

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

var chars = []string{
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
	".", ",", ":", "?", "'", "-", ")", "\"", ", ", "<DO>", "<SK>", "<VA>", "!", ";", "_",
	// 7 morse char.
	"<BK>", "$",
	// 8 morse char.
	"<CL>",
	// 9 morse char.
	"<SOS>"}

var morsechars = []string{
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
	".-.-.-", "--..--", "---...", "..--..", ".----.", "-....-", "-.--.-", ".-..-.", ".--.-.", "-..---", "...-.-", "...-.-", "-.-.--", "-.-.-.", "..--.-",
	// 7 morse char.
	"-...-.-", "...-..-",
	// 8 morse char.
	"-.-..-..",
	// 9 morse char.
	"...---..."}

// Replace non-standard characters by standard.
func replaceIllegalCharacters(toReplace string) string {
	var replaced = toReplace

	// Replace unsecable spaces.
	replaced = strings.Replace(replaced, " ", " ", -1)

	// Replace strange point.
	replaced = strings.Replace(replaced, "·", ".", -1)
	replaced = strings.Replace(replaced, "•", ".", -1)

	// Replace long dash by standard dash.
	replaced = strings.Replace(replaced, "−", "−", -1)
	replaced = strings.Replace(replaced, "−", "−", -1)

	return replaced
}

// Encode into Morse language.
func morse(data string) string {
	if len(data) <= 0 {
		return ""
	}

	// Make all charaters upper.
	var toTranslate = strings.ToUpper(data)

	// Replace illegal characters.
	toTranslate = replaceIllegalCharacters(toTranslate)

	// Replace '.' and '-'
	toTranslate = strings.Replace(toTranslate, ".", "|.|", -1)
	toTranslate = strings.Replace(toTranslate, "-", "|-|", -1)
	toTranslate = strings.Replace(toTranslate, "|.|", ".-.-.- ", -1)
	toTranslate = strings.Replace(toTranslate, "|-|", "-....- ", -1)

	// Convert all other characters.
	for i := len(chars) - 1; i >= 0; i-- {
		ch := chars[i]
		if ch == "." {
			continue
		}
		if ch == "-" {
			continue
		}

		morsech := morsechars[i] + " "
		toTranslate = strings.Replace(toTranslate, ch, morsech, -1)
	}

	return toTranslate
}

// Decode from Morse language.
func demorse(data string) string {
	if len(data) <= 0 {
		return ""
	}

	// Make all charaters upper.
	var toTranslate = strings.ToUpper(data)

	// Replace illegal characters.
	toTranslate = replaceIllegalCharacters(toTranslate)

	// Add end space.
	toTranslate = toTranslate + " "

	// Replace '.' and '-'
	toTranslate = strings.Replace(toTranslate, ".-.-.- ", "|.|", -1)
	toTranslate = strings.Replace(toTranslate, "-....- ", "|-|", -1)

	// Convert all other characters.
	for i := len(chars) - 1; i >= 0; i-- {
		ch := chars[i]
		if ch == "." {
			continue
		}
		if ch == "-" {
			continue
		}

		morsech := morsechars[i] + " "
		toTranslate = strings.Replace(toTranslate, morsech, ch, -1)
	}

	// Replace '.' and '-'
	toTranslate = strings.Replace(toTranslate, "|.|", ".", -1)
	toTranslate = strings.Replace(toTranslate, "|-|", "-", -1)

	return toTranslate
}
