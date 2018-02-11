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
    var countryContents = [MTLCountryContent]()
    
    // MARK: - refresh data
    
    let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    @objc private func refresh() {
        NetworkManager.connectionRequest(with: .GET, urlString: urlString, parameters: nil, success: { (anyJsonDict) in
            if let jsonDict = anyJsonDict as? [AnyHashable: Any],
                let country = try? MTLJSONAdapter.model(of: MTLCountry.self, fromJSONDictionary: jsonDict) as? MTLCountry {
                self.country = country
                self.countryContents = (country?.contents as! [MTLCountryContent]).filter() {
                    $0.title != nil && $0.descr != nil && $0.imageHref != nil
                }
            }
        }) { (error) in
            print(error.debugDescription)
        }
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath)

        // Configure the cell...
        return cell
    }
    */
}
