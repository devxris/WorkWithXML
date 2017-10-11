//
//  NewsCell.swift
//  WorkWithXML
//
//  Created by Chris Huang on 11/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var dateLabel:UILabel!
	@IBOutlet weak var descriptionLabel:UILabel! {
		didSet {
			descriptionLabel.numberOfLines = 4
		}
	}
	
	var rssItem: FeedParser.ContentInfo? {
		didSet {
			titleLabel.text = rssItem?.title
			descriptionLabel.text = rssItem?.description
			dateLabel.text = rssItem?.pubDate
		}
	}
}
