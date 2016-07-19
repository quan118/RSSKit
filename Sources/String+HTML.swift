//
//  String+HTML.swift
//
//  Created by Quan Nguyen on 7/4/16.
//  Copyright © 2016 Niteco, Inc. All rights reserved.
//

import Foundation

extension String {
    public func stringByConvertingHTMLToPlainText() -> String {
        // Character sets
        let stopCharacters = NSCharacterSet(charactersInString: String(format: "< \t\n\r%C%C%C%C", 0x0085, 0x000C, 0x2028, 0x2029))
        let newLineAndWhitespaceCharacters = NSCharacterSet(charactersInString: String(format: " \t\n\r%C%C%C%C", 0x0085, 0x000C, 0x2028, 0x2029))
        let tagNameCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        // Scan and find all tags
        let result = NSMutableString(capacity: self.utf16.count)
        let scanner = NSScanner(string: self)
        scanner.charactersToBeSkipped = nil
        scanner.caseSensitive = true
        var str:NSString? = nil, tagName:NSString? = nil
        var replaceTagWithSpace = true
        
        repeat {
            
            // Scan up to the start of a tag or whitespace
            if scanner.scanUpToCharactersFromSet(stopCharacters, intoString: &str) {
                result.appendString(str! as String)
                str = nil // reset
            }
            
            // Check if we've stopped at a tag/comment or whitespace
            if scanner.scanString("<", intoString: nil) {
                // Stoppped at a comment, script tag, or other tag
                if scanner.scanString("!--", intoString: nil) {
                    // Comment
                    scanner.scanUpToString("-->", intoString: nil)
                    scanner.scanString("-->", intoString: nil)
                } else if scanner.scanString("script", intoString: nil) {
                    // Script tag where things don't need escaping!
                    scanner.scanUpToString("</script>", intoString: nil)
                    scanner.scanString("</script>", intoString: nil)
                } else {
                    // Tag - remove and replace with space unless it's
                    // a closing inline tag then dont replace with a space
                    if scanner.scanString("/", intoString: nil) {
                        // Closing tag - replace with space unless it's inline
                        tagName = nil
                        replaceTagWithSpace = true
                        if scanner.scanCharactersFromSet(tagNameCharacters, intoString: &tagName) {
                            let tagNameInLowercase = tagName?.lowercaseString
                            
                            replaceTagWithSpace = (tagNameInLowercase != "a" &&
                                                   tagNameInLowercase != "b" &&
                                                   tagNameInLowercase != "i" &&
                                                   tagNameInLowercase != "q" &&
                                                   tagNameInLowercase != "span" &&
                                                   tagNameInLowercase != "em" &&
                                                   tagNameInLowercase != "strong" &&
                                                   tagNameInLowercase != "cite" &&
                                                   tagNameInLowercase != "abbr" &&
                                                   tagNameInLowercase != "acronym" &&
                                                   tagNameInLowercase != "label")
                        }
                        
                        // Replace tag with string unless it was an inline
                        if replaceTagWithSpace && result.length > 0 && !scanner.atEnd {
                            result.appendString(" ")
                        }
                    }
                    
                    // Scan past tag
                    scanner.scanUpToString(">", intoString: nil)
                    scanner.scanString(">", intoString: nil)
                }
            } else {
                // Stopped at whitespace - replace all whitespace and newlines with a space
                if scanner.scanCharactersFromSet(newLineAndWhitespaceCharacters, intoString: nil) {
                    if result.length > 0 && !scanner.atEnd {
                        result.appendString(" ")
                    }
                }
            }
        } while !scanner.atEnd
        
        // Cleanup
        
        // Decode HTML entities and return
        let retString = (result as String).stringByDecodingHTMLEntities()
        
        return retString
    }
    
    public func stringByDecodingHTMLEntities() -> String {
        return self.gtm_stringByUnescapingFromHTML()
    }
    
    public func stringByEncodingHTMLEntities() -> String {
        return self.gtm_stringByEscapingForAsciiHTML()
    }
}