//
//  ShowsRepositoryTests.swift
//  RadioPlusTests
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import XCTest
@testable import RadioPlus

final class ShowsRepositoryTests: XCTestCase {
    
    var zut: ShowRepositoryProtocol!
    
    var provider: NetworkProvider!
    var requester: DataServiceProviderProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = APIEndpoint(method: .post, endURL: .api)
        requester = Requester()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_shows_repository() async {
        // given
        zut = ShowRepository(requester: requester)
        
        // with
        let station: Stations = .FRANCECULTURE
        let first: Int = 10
        
        // test
        do {
            let query = try await zut.getShows(for: station, first: first)
        } catch let error {
            XCTFail("Error thrown: \(error)")
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
