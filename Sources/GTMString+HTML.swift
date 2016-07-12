//
//  GTMString+HTML.swift
//
//
//  Created by Quan Nguyen on 6/22/16.
//  Copyright © 2016 Niteco, Inc. All rights reserved.
//

import Foundation

typealias HTMLEscapeMap = (escapeSequence:String, uchar:unichar)

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// Ordered by uchar lowest to highest for bsearching
let gAsciiHTMLEscapeMap:[HTMLEscapeMap] = [
    // A.2.2. Special characters
    ( "&quot;", 34 ),
    ( "&amp;", 38 ),
    ( "&apos;", 39 ),
    ( "&lt;", 60 ),
    ( "&gt;", 62 ),
    
    // A.2.1. Latin-1 characters
    ( "&nbsp;", 160 ),
    ( "&iexcl;", 161 ),
    ( "&cent;", 162 ),
    ( "&pound;", 163 ),
    ( "&curren;", 164 ),
    ( "&yen;", 165 ),
    ( "&brvbar;", 166 ),
    ( "&sect;", 167 ),
    ( "&uml;", 168 ),
    ( "&copy;", 169 ),
    ( "&ordf;", 170 ),
    ( "&laquo;", 171 ),
    ( "&not;", 172 ),
    ( "&shy;", 173 ),
    ( "&reg;", 174 ),
    ( "&macr;", 175 ),
    ( "&deg;", 176 ),
    ( "&plusmn;", 177 ),
    ( "&sup2;", 178 ),
    ( "&sup3;", 179 ),
    ( "&acute;", 180 ),
    ( "&micro;", 181 ),
    ( "&para;", 182 ),
    ( "&middot;", 183 ),
    ( "&cedil;", 184 ),
    ( "&sup1;", 185 ),
    ( "&ordm;", 186 ),
    ( "&raquo;", 187 ),
    ( "&frac14;", 188 ),
    ( "&frac12;", 189 ),
    ( "&frac34;", 190 ),
    ( "&iquest;", 191 ),
    ( "&Agrave;", 192 ),
    ( "&Aacute;", 193 ),
    ( "&Acirc;", 194 ),
    ( "&Atilde;", 195 ),
    ( "&Auml;", 196 ),
    ( "&Aring;", 197 ),
    ( "&AElig;", 198 ),
    ( "&Ccedil;", 199 ),
    ( "&Egrave;", 200 ),
    ( "&Eacute;", 201 ),
    ( "&Ecirc;", 202 ),
    ( "&Euml;", 203 ),
    ( "&Igrave;", 204 ),
    ( "&Iacute;", 205 ),
    ( "&Icirc;", 206 ),
    ( "&Iuml;", 207 ),
    ( "&ETH;", 208 ),
    ( "&Ntilde;", 209 ),
    ( "&Ograve;", 210 ),
    ( "&Oacute;", 211 ),
    ( "&Ocirc;", 212 ),
    ( "&Otilde;", 213 ),
    ( "&Ouml;", 214 ),
    ( "&times;", 215 ),
    ( "&Oslash;", 216 ),
    ( "&Ugrave;", 217 ),
    ( "&Uacute;", 218 ),
    ( "&Ucirc;", 219 ),
    ( "&Uuml;", 220 ),
    ( "&Yacute;", 221 ),
    ( "&THORN;", 222 ),
    ( "&szlig;", 223 ),
    ( "&agrave;", 224 ),
    ( "&aacute;", 225 ),
    ( "&acirc;", 226 ),
    ( "&atilde;", 227 ),
    ( "&auml;", 228 ),
    ( "&aring;", 229 ),
    ( "&aelig;", 230 ),
    ( "&ccedil;", 231 ),
    ( "&egrave;", 232 ),
    ( "&eacute;", 233 ),
    ( "&ecirc;", 234 ),
    ( "&euml;", 235 ),
    ( "&igrave;", 236 ),
    ( "&iacute;", 237 ),
    ( "&icirc;", 238 ),
    ( "&iuml;", 239 ),
    ( "&eth;", 240 ),
    ( "&ntilde;", 241 ),
    ( "&ograve;", 242 ),
    ( "&oacute;", 243 ),
    ( "&ocirc;", 244 ),
    ( "&otilde;", 245 ),
    ( "&ouml;", 246 ),
    ( "&divide;", 247 ),
    ( "&oslash;", 248 ),
    ( "&ugrave;", 249 ),
    ( "&uacute;", 250 ),
    ( "&ucirc;", 251 ),
    ( "&uuml;", 252 ),
    ( "&yacute;", 253 ),
    ( "&thorn;", 254 ),
    ( "&yuml;", 255 ),
    
    // A.2.2. Special characters cont'd
    ( "&OElig;", 338 ),
    ( "&oelig;", 339 ),
    ( "&Scaron;", 352 ),
    ( "&scaron;", 353 ),
    ( "&Yuml;", 376 ),
    
    // A.2.3. Symbols
    ( "&fnof;", 402 ),
    
    // A.2.2. Special characters cont'd
    ( "&circ;", 710 ),
    ( "&tilde;", 732 ),
    
    // A.2.3. Symbols cont'd
    ( "&Alpha;", 913 ),
    ( "&Beta;", 914 ),
    ( "&Gamma;", 915 ),
    ( "&Delta;", 916 ),
    ( "&Epsilon;", 917 ),
    ( "&Zeta;", 918 ),
    ( "&Eta;", 919 ),
    ( "&Theta;", 920 ),
    ( "&Iota;", 921 ),
    ( "&Kappa;", 922 ),
    ( "&Lambda;", 923 ),
    ( "&Mu;", 924 ),
    ( "&Nu;", 925 ),
    ( "&Xi;", 926 ),
    ( "&Omicron;", 927 ),
    ( "&Pi;", 928 ),
    ( "&Rho;", 929 ),
    ( "&Sigma;", 931 ),
    ( "&Tau;", 932 ),
    ( "&Upsilon;", 933 ),
    ( "&Phi;", 934 ),
    ( "&Chi;", 935 ),
    ( "&Psi;", 936 ),
    ( "&Omega;", 937 ),
    ( "&alpha;", 945 ),
    ( "&beta;", 946 ),
    ( "&gamma;", 947 ),
    ( "&delta;", 948 ),
    ( "&epsilon;", 949 ),
    ( "&zeta;", 950 ),
    ( "&eta;", 951 ),
    ( "&theta;", 952 ),
    ( "&iota;", 953 ),
    ( "&kappa;", 954 ),
    ( "&lambda;", 955 ),
    ( "&mu;", 956 ),
    ( "&nu;", 957 ),
    ( "&xi;", 958 ),
    ( "&omicron;", 959 ),
    ( "&pi;", 960 ),
    ( "&rho;", 961 ),
    ( "&sigmaf;", 962 ),
    ( "&sigma;", 963 ),
    ( "&tau;", 964 ),
    ( "&upsilon;", 965 ),
    ( "&phi;", 966 ),
    ( "&chi;", 967 ),
    ( "&psi;", 968 ),
    ( "&omega;", 969 ),
    ( "&thetasym;", 977 ),
    ( "&upsih;", 978 ),
    ( "&piv;", 982 ),
    
    // A.2.2. Special characters cont'd
    ( "&ensp;", 8194 ),
    ( "&emsp;", 8195 ),
    ( "&thinsp;", 8201 ),
    ( "&zwnj;", 8204 ),
    ( "&zwj;", 8205 ),
    ( "&lrm;", 8206 ),
    ( "&rlm;", 8207 ),
    ( "&ndash;", 8211 ),
    ( "&mdash;", 8212 ),
    ( "&lsquo;", 8216 ),
    ( "&rsquo;", 8217 ),
    ( "&sbquo;", 8218 ),
    ( "&ldquo;", 8220 ),
    ( "&rdquo;", 8221 ),
    ( "&bdquo;", 8222 ),
    ( "&dagger;", 8224 ),
    ( "&Dagger;", 8225 ),
    // A.2.3. Symbols cont'd
    ( "&bull;", 8226 ),
    ( "&hellip;", 8230 ),
    
    // A.2.2. Special characters cont'd
    ( "&permil;", 8240 ),
    
    // A.2.3. Symbols cont'd
    ( "&prime;", 8242 ),
    ( "&Prime;", 8243 ),
    
    // A.2.2. Special characters cont'd
    ( "&lsaquo;", 8249 ),
    ( "&rsaquo;", 8250 ),
    
    // A.2.3. Symbols cont'd
    ( "&oline;", 8254 ),
    ( "&frasl;", 8260 ),
    
    // A.2.2. Special characters cont'd
    ( "&euro;", 8364 ),
    
    // A.2.3. Symbols cont'd
    ( "&image;", 8465 ),
    ( "&weierp;", 8472 ),
    ( "&real;", 8476 ),
    ( "&trade;", 8482 ),
    ( "&alefsym;", 8501 ),
    ( "&larr;", 8592 ),
    ( "&uarr;", 8593 ),
    ( "&rarr;", 8594 ),
    ( "&darr;", 8595 ),
    ( "&harr;", 8596 ),
    ( "&crarr;", 8629 ),
    ( "&lArr;", 8656 ),
    ( "&uArr;", 8657 ),
    ( "&rArr;", 8658 ),
    ( "&dArr;", 8659 ),
    ( "&hArr;", 8660 ),
    ( "&forall;", 8704 ),
    ( "&part;", 8706 ),
    ( "&exist;", 8707 ),
    ( "&empty;", 8709 ),
    ( "&nabla;", 8711 ),
    ( "&isin;", 8712 ),
    ( "&notin;", 8713 ),
    ( "&ni;", 8715 ),
    ( "&prod;", 8719 ),
    ( "&sum;", 8721 ),
    ( "&minus;", 8722 ),
    ( "&lowast;", 8727 ),
    ( "&radic;", 8730 ),
    ( "&prop;", 8733 ),
    ( "&infin;", 8734 ),
    ( "&ang;", 8736 ),
    ( "&and;", 8743 ), 
    ( "&or;", 8744 ), 
    ( "&cap;", 8745 ), 
    ( "&cup;", 8746 ), 
    ( "&int;", 8747 ), 
    ( "&there4;", 8756 ), 
    ( "&sim;", 8764 ), 
    ( "&cong;", 8773 ), 
    ( "&asymp;", 8776 ), 
    ( "&ne;", 8800 ), 
    ( "&equiv;", 8801 ), 
    ( "&le;", 8804 ), 
    ( "&ge;", 8805 ), 
    ( "&sub;", 8834 ), 
    ( "&sup;", 8835 ), 
    ( "&nsub;", 8836 ), 
    ( "&sube;", 8838 ), 
    ( "&supe;", 8839 ), 
    ( "&oplus;", 8853 ), 
    ( "&otimes;", 8855 ), 
    ( "&perp;", 8869 ), 
    ( "&sdot;", 8901 ), 
    ( "&lceil;", 8968 ), 
    ( "&rceil;", 8969 ), 
    ( "&lfloor;", 8970 ), 
    ( "&rfloor;", 8971 ), 
    ( "&lang;", 9001 ), 
    ( "&rang;", 9002 ), 
    ( "&loz;", 9674 ), 
    ( "&spades;", 9824 ), 
    ( "&clubs;", 9827 ), 
    ( "&hearts;", 9829 ), 
    ( "&diams;", 9830 )
]

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// This is table A.2.2 Special Characters
let gUnicodeHTMLEscapeMap:[HTMLEscapeMap] = [
    // C0 Controls and Basic Latin
    ( "&quot;", 34 ),
    ( "&amp;", 38 ),
    ( "&apos;", 39 ),
    ( "&lt;", 60 ),
    ( "&gt;", 62 ),
    
    // Latin Extended-A
    ( "&OElig;", 338 ),
    ( "&oelig;", 339 ),
    ( "&Scaron;", 352 ),
    ( "&scaron;", 353 ),
    ( "&Yuml;", 376 ),
    
    // Spacing Modifier Letters
    ( "&circ;", 710 ),
    ( "&tilde;", 732 ),
    
    // General Punctuation
    ( "&ensp;", 8194 ),
    ( "&emsp;", 8195 ),
    ( "&thinsp;", 8201 ),
    ( "&zwnj;", 8204 ),
    ( "&zwj;", 8205 ),
    ( "&lrm;", 8206 ),
    ( "&rlm;", 8207 ),
    ( "&ndash;", 8211 ),
    ( "&mdash;", 8212 ),
    ( "&lsquo;", 8216 ),
    ( "&rsquo;", 8217 ),
    ( "&sbquo;", 8218 ),
    ( "&ldquo;", 8220 ),
    ( "&rdquo;", 8221 ),
    ( "&bdquo;", 8222 ),
    ( "&dagger;", 8224 ),
    ( "&Dagger;", 8225 ),
    ( "&permil;", 8240 ),
    ( "&lsaquo;", 8249 ),
    ( "&rsaquo;", 8250 ),
    ( "&euro;", 8364 )
]

extension String {
    static private func escapeMapCompare(uchar:unichar, map:HTMLEscapeMap) -> Int {
        var val = 0
        
        if uchar > map.uchar {
            val = 1
        } else if (uchar < map.uchar) {
            val = -1
        } else {
            val = 0
        }
        
        return val
    }
    
    static private func bsearch(codeUnit:unichar, table:[HTMLEscapeMap]) -> HTMLEscapeMap? {
        var first = 0, last = table.count-1
        while first <= last {
            let mid = (first + last) / 2
            if table[mid].uchar == codeUnit {
                return table[mid]
            } else if table[mid].uchar < codeUnit {
                first = mid + 1
            } else {
                last = mid - 1
            }
        }
        
        return nil
    }
    
    func gtm_stringByEscapingHTMLUsingTable(table:[HTMLEscapeMap], escapingUnicode:Bool) -> String {
        // 1. Get length of this string (in utf16). if length == 0 then return self
        // 2. Create an array of utf16 code unit from content of this string
        // 3. Iterate through the array, look up code unit in
        
        
        let length = self.utf16.count
        if length == 0 {
            return self
        }

        var finalString = ""
        
        for codeunit in self.utf16 {
            let val = String.bsearch(codeunit, table: table)
            
            if val != nil || (escapingUnicode && codeunit > 127) {
                if let val = val {
                    finalString += val.escapeSequence
                } else {
                    finalString += "&#\(codeunit);"
                }
            } else {
                finalString.append(UnicodeScalar(codeunit))
            }
        }
        
        return finalString
    }
    
    // From '<span>blah<span>' to '&lt;span&gt;blah&lt;span&gt;'
    public func gtm_stringByEscapingForHTML() -> String {
        return gtm_stringByEscapingHTMLUsingTable(gUnicodeHTMLEscapeMap, escapingUnicode: false)
    }
    
    // From '&lt;span&gt;blah&lt;span&gt;' to '<span>blah<span>'
    public func gtm_stringByUnescapingFromHTML() -> String {
        var range = self.startIndex..<self.endIndex
        var subrange = self.rangeOfString("&", options: NSStringCompareOptions.BackwardsSearch, range: range, locale: nil)
        
        // if no ampersands, we've got a quick way out
        if subrange == nil || subrange?.count == 0 {
            return self
        }
        var finalString = String(self)
        
        repeat {
            var semiColonRange:Range<String.Index>? = subrange!.startIndex..<range.endIndex
            semiColonRange = self.rangeOfString(";", options: NSStringCompareOptions.CaseInsensitiveSearch, range: semiColonRange, locale: nil)
            range = self.startIndex..<subrange!.startIndex
            // if we don't find a semicolon in the range, we don't have a sequence
            if semiColonRange == nil {
                subrange = self.rangeOfString("&", options: NSStringCompareOptions.BackwardsSearch, range: range, locale: nil)
                continue
            }
            let escapeRange = subrange!.startIndex...semiColonRange!.startIndex
            let escapeString = self.substringWithRange(escapeRange)
            let length = escapeString.characters.count
            
            // a sequence must be longer than 3 (&lt;) and less than 11 (&thetasym;)
            if length > 3 && length < 11 {
                if escapeString[escapeString.startIndex.advancedBy(1)] == "#" {
                    let char2 = escapeString[escapeString.startIndex.advancedBy(2)]
                    if char2 == "x" || char2 == "X" {
                        // Hex escape sequences &#xa3;
                        let subrange2 = escapeString.startIndex.advancedBy(3)..<escapeString.endIndex.predecessor()
                        let hexSequence = escapeString.substringWithRange(subrange2)
                        let scanner = NSScanner(string: hexSequence)
                        var value:CUnsignedInt = 0
                        if scanner.scanHexInt(&value) && value < UInt32(CUnsignedShort.max) && value > 0 && scanner.scanLocation == length - 4 {
                            let charString = String(Character(UnicodeScalar(value)))
                            finalString.replaceRange(escapeRange, with: charString)
                        }
                    } else {
                        // Decimal Sequences &#123;
                        let subrange2 = escapeString.startIndex.advancedBy(2)..<escapeString.endIndex.predecessor()
                        let numberSequence = escapeString.substringWithRange(subrange2)
                        let scanner = NSScanner(string: numberSequence)
                        var value:Int32 = 0
                        if scanner.scanInt(&value) && value < Int32(CUnsignedShort.max) && value > 0 && scanner.scanLocation == length - 3 {
                            let charString = String(Character(UnicodeScalar(UInt32(value))))
                            finalString.replaceRange(escapeRange, with: charString)
                        }
                    }
                } else {
                    // "standard" sequences
                    for kv in gAsciiHTMLEscapeMap {
                        if escapeString == kv.escapeSequence {
                            finalString.replaceRange(escapeRange, with: String(Character(UnicodeScalar(kv.uchar))))
                            break
                        }
                    }
                }
            }
            
            subrange = self.rangeOfString("&", options: NSStringCompareOptions.BackwardsSearch, range: range, locale: nil)
        } while subrange != nil && subrange?.count != 0
        
        return finalString
    }
    
    public func gtm_stringByEscapingForAsciiHTML() -> String {
        return gtm_stringByEscapingHTMLUsingTable(gAsciiHTMLEscapeMap, escapingUnicode: true)
    }
}