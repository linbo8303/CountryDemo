//
//  CountryDemoTests.swift
//  CountryDemoTests
//
//  Created by Bo Lin on 13/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

import XCTest
import Mantle
@testable import CountryDemo

class CountryDemoTests: XCTestCase {
    
    var countryTVC: CountryTableViewController!
    var country: MTLCountry!
    var countryConntents: [MTLCountryContent]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryTVC = CountryTableViewController()
        
        if let path = Bundle(for: type(of: self)).path(forResource: "Canada", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [AnyHashable: Any],
                    let country = try? MTLJSONAdapter.model(of: MTLCountry.self, fromJSONDictionary: jsonDict) as? MTLCountry {
                    self.country = country
                    self.countryConntents = country?.contents as! [MTLCountryContent]
                }
            } catch {
                assertionFailure("access data faiiled")
            }
        }
        
        countryTVC.country = country
        countryTVC.countryContents = countryConntents
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNavBarTitle() {
        XCTAssertNotNil(countryTVC.title, "CountryTableViewController title should not be nil")
        XCTAssertEqual(countryTVC.title, country.title)
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(countryTVC.tableView.numberOfRows(inSection: 0), countryConntents.count)
    }
    
}
