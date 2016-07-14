# RSSKit
[![Build Status](https://travis-ci.org/quan118/RSSKit.svg?branch=master)](https://travis-ci.org/quan118/RSSKit)

A Swift library for fetching, parsing and update RSS/Atom feed

# Installation #

## CocoaPods

[CocoaPods](http://cocopods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate RSSKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!
pod 'RSSKit', '~> 1.0.8'
```

Then, run the following command:

```bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

For more information about how to use CocoaPods, I suggest [this tutorial](http://www.raywenderlich.com/64546/introduction-to-cocoapods-2).

# Usage #

## Setting up the parser

Create parser:

	// Create feed parser and pass the URL of the feed
	let feedURL:NSURL = NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss")
	let feedParser:FeedParser = RSSFeedParser(feedURL:url)

Set delegate:
	
	// Delegate must conform to `RSSFeedParserDelegate`
	feedParser.delegate = self

Set the parsing type. Options are `ParseType.Full`, `ParseType.ItemsOnly`, `ParseType.InfoOnly`. Info refers to the information about the feed, such as it's title and description. Items are the invididual items or stories.

	// Parse the feeds info (title, link) and all feed items
	feedParser.feedParseType = ParseType.Full

Set whether the parser should connect and download the feed data synchronously or asynchronously. Note, this only affects the download of the feed data, not the parsing operation itself.

	// Connection type
	feedParser.connectionType = ConnectionType.Asynchronously

Initiate parsing:
	
	// Begin parsing
	feedParser.parse()

The parser will then download and parse the feed. If at any time you wish to stop the parsing, you can call:

	// Stop feed download / parsing
	feedParser.stopParsing()

The `stopParsing` method will stop the downloading and parsing of the feed immediately.

## Reading the feed data

Once parsing has been initiated, the delegate will receive the feed data as it is parsed.

	optional func feedParserDidStart(parser:RSSFeedParser) // Called when data has downloaded and parsing has begun
    optional func feedParser(parser:RSSFeedParser, didParseFeedInfo info:RSSFeedInfo) // Provides info about the feed
    optional func feedParser(parser:RSSFeedParser, didParseFeedItem item:RSSFeedItem) // Provides info about a feed item
    optional func feedParserDidFinish(parser:RSSFeedParser) // Parsing complete or stopped at any time by `stopParsing`
    optional func feedParser(parser:RSSFeedParser, didFailWithError error: NSError) // Parsing failed

`RSSFeedInfo` and `RSSFeedItem` contains properties (title, link, summary, etc.) that will hold the parsed data. View `RSSFeedInfo.swift` and `RSSFeedItem.swift` for more information.

## Available data

Here is a list of the available properties for feed info and item objects:

#### RSSFeedInfo

- `info.title` (`String?`)
- `info.link` (`String?`)
- `info.summary` (`String?`)

#### RSSFeedItem

- `item.title` (`String?`)
- `item.link` (`String?`)
- `item.author` (`String?`)
- `item.date` (`NSDate?`)
- `item.updated` (`NSDate?`)
- `item.summary` (`String?`)
- `item.content` (`String?`)
- `item.enclosures` (`Array` of `Dictionary` with keys `url`, `type` and `length`)
- `item.identifier` (`String?`)

## Using the data

All properties of `RSSFeedInfo` and `RSSFeedItem` return raw data as provided by the feed. This content may or may not include HTML and encoded entities. If the content does include HTML, you could display the data within a UIWebView, or you could use the provided `String` category (`String+HTML`) which will allow you to manipulate this HTML content. The methods available for your convenience are:

	// Convert HTML to Plain Text
	// - Strips HML tags & comments, removes extra whitespace and decodes HTML character entities
	public func stringByConvertingHTMLToPlainText() -> String

	// Decode all HTML entities using GTM.
	public func stringByDecodingHTMLEntities() -> String

	// Encode all HTML entities using GTM
	public func stringByEncodingHTMLEntities() -> String

# License #

RSSKit is released under the MIT license. See LICENSE for details.
