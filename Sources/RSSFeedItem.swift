//
//  RSSFeedItem.swift
//  RSSKit
//
//  Created by Quan Nguyen on 7/7/16.
//
//

import Foundation

public class RSSFeedItem: NSObject {
    public var identifier:String?
    public var title:String?
    public var link:String?
    public var date:NSDate?        // Date the item was published
    public var updated:NSDate?     // Date the item was updated if available
    public var summary:String?
    public var content:String?
    public var author:String?
    
    // Enclosures: Holds 1 ore more item enclosures (i.e. podcasts, mp3. pdf, etc)
    // - Array of dictionaries with the following keys:
    //      url: where the enclosure is located (String)
    //      length: how big it is in bytes (Int)
    //      type: what its type is, a standard MIME type (String)
    public var enclosures:[AnyObject]?
    
    public override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        identifier = aDecoder.decodeObjectForKey("identifier") as? String
        title = aDecoder.decodeObjectForKey("title") as? String
        link = aDecoder.decodeObjectForKey("link") as? String
        date = aDecoder.decodeObjectForKey("date") as? NSDate
        updated = aDecoder.decodeObjectForKey("updated") as? NSDate
        summary = aDecoder.decodeObjectForKey("summary") as? String
        content = aDecoder.decodeObjectForKey("content") as? String
        author = aDecoder.decodeObjectForKey("author") as? String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(identifier, forKey: "identifier")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(link, forKey: "link")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(updated, forKey: "updated")
        aCoder.encodeObject(summary, forKey: "summary")
        aCoder.encodeObject(content, forKey: "content")
        aCoder.encodeObject(author, forKey: "author")
    }
    
    override public var description: String {
        let str = "RSSFeedItem: " + (title ?? "") + (date != nil ? " - \(date)" : "")
        
        return str
    }
}
