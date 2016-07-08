//
//  RSSFeedInfo.swift
//  RSSKit
//
//  Created by Quan Nguyen on 7/7/16.
//
//

import Foundation

public class RSSFeedInfo: NSObject, NSCoding {
    public var title:String?
    public var link:String?
    public var summary:String?
    public var url:NSURL?
    
    public override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as? String
        link = aDecoder.decodeObjectForKey("link") as? String
        summary = aDecoder.decodeObjectForKey("summary") as? String
        url = aDecoder.decodeObjectForKey("url") as? NSURL
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(link, forKey: "link")
        aCoder.encodeObject(summary, forKey: "summary")
        aCoder.encodeObject(url, forKey: "url")
    }
    
    override public var description: String {
        let str = "RSSFeedInfo: " + (title ?? "")
        
        return str
    }
}
