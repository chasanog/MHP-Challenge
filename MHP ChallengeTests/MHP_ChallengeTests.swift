//
//  MHP_ChallengeTests.swift
//  MHP ChallengeTests
//
//  Created by Cihan Hasanoglu on 11.12.21.
//

import XCTest
@testable import MHP_Challenge

class MHP_ChallengeTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // testing download function of our APIService
    func testExample() throws {
        var houseArray: [IAFHouse]?
        var linkHeaders: LinkHeaderParser?
        let apiService = APIService()
        let expectations = expectation(description: "testDownloadData")
        
        apiService.downloadData(1, 50) {(houseObject: [IAFHouse]?, error: Error?, responseLinkHeaders: LinkHeaderParser?) -> Void in
            houseArray = houseObject
            linkHeaders = responseLinkHeaders
            expectations.fulfill()
        }
        
        
        waitForExpectations(timeout: 10) {(error) -> Void in
            XCTAssertNotNil(houseArray)
            XCTAssertNotNil(linkHeaders)
            XCTAssertNotNil(linkHeaders?.next)
            XCTAssertNotNil(linkHeaders?.last)
        }
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
