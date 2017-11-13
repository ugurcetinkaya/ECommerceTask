//
//  ECommerceTaskTests.swift
//  ECommerceTaskTests
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import XCTest
@testable import ECommerceTask

import Unbox

class ECommerceTaskTests: XCTestCase {
    
    var json: UnboxableDictionary!
    
    override func setUp() {
        super.setUp()
        
        json = loadJSON()
    }
    
    func testMappingOfProductModel() {
        do {
            let productModel: ProductModel = try unbox(dictionary: json)
            
            XCTAssertNotNil(productModel)
            XCTAssertNotNil(productModel.productId)
            XCTAssertNotNil(productModel.name)
            XCTAssertNotNil(productModel.description)
            XCTAssertNotNil(productModel.price)
            XCTAssertNotNil(productModel.image)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
    
    func testStringFromHtml() {
        do {
            let attributedString: NSAttributedString = try DataManager.stringFromHtml(string: readHtmlString())!
            
            XCTAssertNotNil(attributedString)
            XCTAssertNotNil(attributedString.string)
        }
        catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
    
}

extension XCTestCase {
    
    func loadJSON() -> UnboxableDictionary {
        let data = readFile(name: "data", type: "json")
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        return json as! UnboxableDictionary
    }
    
    func readHtmlString() throws -> String {
        let data: Data = readFile(name: "htmlString", type: "txt")
        let htmlString = String(data: data, encoding: String.Encoding.utf8) as String!
        return htmlString!
    }
    
    func readFile(name: String, type: String)  -> Data {
        let path: String? = Bundle(for: type(of: self)).path(forResource: name, ofType: type)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return data!
    }
}
