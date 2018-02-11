//
//  CountryTableViewController.swift
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

import UIKit
import Mantle

class CountryTableViewController: UITableViewController {
    
    // MARK: - Models
    var country: MTLCountry? {
        didSet {
            navigationItem.title = country?.title
        }
    }
    var countryContents = [MTLCountryContent]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private struct Storyboard {
        static let CellIdentifier = "ContentCell"
    }
    
    // MARK: - refresh data
    
    let CNCountryTableViewControllerURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    @objc private func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        // load data and set value to models
        NetworkManager.connectionRequest(with: .GET, urlString: CNCountryTableViewControllerURLString, parameters: nil, success: { (anyJsonDict) in
            if let jsonDict = anyJsonDict as? [AnyHashable: Any],
                let country = try? MTLJSONAdapter.model(of: MTLCountry.self, fromJSONDictionary: jsonDict) as? MTLCountry {
                self.country = country
                self.countryContents = (country?.contents as! [MTLCountryContent]).filter() {
                    $0.title != nil || $0.descr != nil || $0.imageHref != nil
                }
            }
            self.refreshControl?.endRefreshing()
        }) { (error) in
            print(error.debugDescription)
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view setting
        tableView.register(ContentCell.self, forCellReuseIdentifier: Storyboard.CellIdentifier)
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        // add refresh control
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loosen and Fetching...")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        
        refresh()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryContents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath)

        // Configure the cell...
        let content = countryContents[indexPath.row]
        if let contentCell = cell as? ContentCell {
            contentCell.content = content
        }
        
        return cell
    }
}
