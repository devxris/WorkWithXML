//
//  NewsTableViewController.swift
//  WorkWithXML
//
//  Created by Chris Huang on 11/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
	
	private var rssItems: [FeedParser.ContentInfo]?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
		
		fetchRSS()
	}
	
	private func fetchRSS() {
		let feedParser = FeedParser()
		feedParser.parseFeed(feedUrl: "https://www.apple.com/main/rss/hotnews/hotnews.rss") { rssItems in
			self.rssItems = rssItems
			DispatchQueue.main.async {
				self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
			}
		}
	}
	
	
	// MARK: UITableViewDataSource and UITableViewDelegate
	
	override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rssItems?.count ?? 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
		cell.rssItem = rssItems?[indexPath.row]
		return cell
	}
}
