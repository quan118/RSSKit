//
//  RSSError.swift
//  RSSKit
//
//  Created by Quan Nguyen on 7/7/16.
//
//

import Foundation

public struct RSSError {
    public static let Domain = "RSSFeedParser"
    
    public enum Code : Int {
        case NotInitiated           =   1
        case ConnectionFailed       =   2
        case FeedParsingError       =   3
        case FeedValidationError    =   4
        case General                =   5
    }
    
    public static func errorWithCode(code:Code, failureReason:String) -> NSError {
        return NSError(domain: Domain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey:failureReason])
    }
}
