//
//  Fast_NewsTests.swift
//  Fast NewsTests
//
//  Created by Lucas Moreton on 16/09/19.
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import XCTest
@testable import Fast_News

class Fast_NewsTests: XCTestCase {

    func testLoadItens()
    {
        let e = expectation(description: "Alamofire")
        
        HotNewsProvider.shared.hotNews { (completion) in
            do {
                let hotNews = try completion()
                XCTAssertNotNil(hotNews, "hotNews is nil")
                XCTAssertEqual(hotNews.count > 0, true, "hotNews no has data")
            } catch {
                XCTFail()
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    func testLoadComments()
    {
        let e = expectation(description: "Alamofire")
        
        
        HotNewsProvider.shared.hotNewsComments(id: "g3y1cu") { (completion) in
            do {
                let comments = try completion()
                XCTAssertNotNil(comments, "comments is nil")
                XCTAssertEqual(comments.count > 0, true, "comments has no data")
            
            } catch {
                XCTFail()
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
}
