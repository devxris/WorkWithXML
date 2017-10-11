//
//  FeedParser.swift
//  WorkWithXML
//
//  Created by Chris Huang on 11/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

class FeedParser: NSObject {
	
 typealias ContentInfo = (title: String, description: String, pubDate: Date)
	
	private var rssItems: [ContentInfo] = []
	
	private var currentElement = ""
	private var currentTitle: String = "" {
		didSet { currentTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines) }
	}
	private var currentDescription: String = "" {
		didSet { currentDescription = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines) }
	}
	private var currentPubDate: String = "" {
		didSet { currentPubDate = currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines) }
	}
	private var completionHander: (([ContentInfo]) -> ())?
	
	func parseFeed(feedUrl: String, completionHandler: (([ContentInfo]) -> ())?) {
		
		self.completionHander = completionHandler
		
		guard let url = URL(string: feedUrl) else { return }
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else { if let error = error { print( error.localizedDescription)}; return }
			
			// Parse XML data
			let parser = XMLParser(data: data)
			parser.delegate = self
			parser.parse()
			
		}.resume()
	}
}

extension FeedParser: XMLParserDelegate {
	
}
