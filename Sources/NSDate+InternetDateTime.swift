//
//  NSDate+InternetDateTime.swift
//
//  Created by Quan Nguyen on 6/27/16.
//  Copyright © 2016 Niteco, Inc. All rights reserved.
//

import Foundation

var _internetDateTimeFormatter:NSDateFormatter? = nil

enum DateFormatHint {
    case None
    case RFC822
    case RFC3339
}

extension NSDate {
    
    private static func internetDateTimeFormatter() -> NSDateFormatter {
        if _internetDateTimeFormatter == nil {
            let en_US_POSIX = NSLocale(localeIdentifier: "en_US_POSIX")
            _internetDateTimeFormatter = NSDateFormatter()
            _internetDateTimeFormatter?.locale = en_US_POSIX
            _internetDateTimeFormatter?.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        }
        
        return _internetDateTimeFormatter!
    }
    
    static func dateFromInternetDateTimeString(dateString:String, formatHint hint:DateFormatHint) -> NSDate? {
        var date:NSDate? = nil
        
        if hint != .RFC3339 {
            // Try RFC822 first
            date = NSDate.dateFromRFC822String(dateString)
            if date == nil {
                date = NSDate.dateFromRFC3339String(dateString)
            }
        } else {
            // Try RFC3339 first
            date = NSDate.dateFromRFC3339String(dateString)
            if date == nil {
                date = NSDate.dateFromRFC822String(dateString)
            }
        }
        
        return date
    }
    
    static func dateFromRFC3339String(dateString:String) -> NSDate? {
        var date:NSDate? = nil
        
        let dateFormatter = NSDate.internetDateTimeFormatter()
        // Process date
        var RFC3339String = dateString.uppercaseString
        RFC3339String = RFC3339String.stringByReplacingOccurrencesOfString("Z", withString: "-0000")
        // Remove colon in timezone as it breaks NSDateFormatter in iOS 4+
        
        if RFC3339String.characters.count > 20 {
            let range = Range<String.Index>(RFC3339String.startIndex.advancedBy(20)..<RFC3339String.endIndex)
            RFC3339String = RFC3339String.stringByReplacingOccurrencesOfString(":",
                                                                               withString: "",
                                                                               options: [],
                                                                               range: range)
        }
        
        if date == nil { // 1996-12-19T16:39:57-0800
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            date = dateFormatter.dateFromString(RFC3339String)
        }
        if date == nil { // 1937-01-01T12:00:27.87+0020
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"
            date = dateFormatter.dateFromString(RFC3339String)
        }
        if date == nil { // 1937-01-01T12:00:27
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
            date = dateFormatter.dateFromString(RFC3339String)
        }
        
        return date
    }
    
    static func dateFromRFC822String(dateString:String) -> NSDate? {
        var date:NSDate? = nil
        
        let dateFormatter = NSDate.internetDateTimeFormatter()
        let RFC822String = dateString.uppercaseString
        
        if RFC822String.rangeOfString(",") != nil {
            if date == nil { // Sun, 19 May 2002 15:21:36 GMT
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // Sun, 19 May 2002, 15:21 GMT
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm zzz"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // Sun, 19 May 2002 15:21:36
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // Sun, 19 May 2002 15:21
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm"
                date = dateFormatter.dateFromString(RFC822String)
            }
        } else {
            if date == nil { // 19 May 2002 15:21:36 GMT
                dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss zzz"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // 19 May 2002 15:21 GMT
                dateFormatter.dateFormat = "d MMM yyyy HH:mm zzz"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // 19 May 2002 15:21:36
                dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss"
                date = dateFormatter.dateFromString(RFC822String)
            }
            
            if date == nil { // 19 May 2002 15:21
                dateFormatter.dateFormat = "d MMM yyyy HH:mm"
                date = dateFormatter.dateFromString(RFC822String)
            }
        }
        
        return date
    }
}