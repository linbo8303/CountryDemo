//
//  CountryDemoDataTests.swift
//  CountryDemoDataTests
//
//  Created by Bo Lin on 13/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

import XCTest
import Mantle
@testable import CountryDemo

class CountryDemoDataTests: XCTestCase {
    
    var country: MTLCountry?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = Bundle(for: type(of: self)).path(forResource: "Canada", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [AnyHashable: Any],
                    let country = try? MTLJSONAdapter.model(of: MTLCountry.self, fromJSONDictionary: jsonDict) as? MTLCountry {
                    self.country = country
                }
            } catch {
                assertionFailure("access data faiiled")
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        country = nil
        super.tearDown()
    }
    
    func testCountryInit() {
        if let country = self.country {
            XCTAssertEqual(country.title, "About Canada")
            XCTAssertEqual(country.contents.count, 14)
        } else {
            XCTFail("Country initialization fail")
        }
    }
    
    func testCountryContentInit() {
        if let contents = country?.contents as? [MTLCountryContent] {
            XCTAssertEqual(contents.count, 14)
            
            XCTAssertEqual(contents.first?.title, "Beavers")
            XCTAssertEqual(contents.first?.descr, "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
            XCTAssertEqual(contents.first?.imageHref, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
            
            XCTAssertEqual(contents.last?.title, "Language")
            XCTAssertEqual(contents.last?.descr, "Nous parlons tous les langues importants.")
            XCTAssertNil(contents.last?.imageHref, "CountryContent imageHref is nil")
        } else {
            XCTFail("CountryContent initialization fail")
        }
    }
    
}
