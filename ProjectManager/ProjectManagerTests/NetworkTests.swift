
//  NetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/03.


import XCTest
@testable import ProjectManager

class NetworkTests: XCTestCase {
    var urlSession: MockURLSession!
    var networkManager: NetworkManager!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        urlSession = nil
        networkManager = nil
    }

    func test_failure_ResponseStatusCode_400() {
        urlSession = MockURLSession(response: HTTPURLResponse(url: URL(string: "www")!, statusCode: 400, httpVersion: nil, headerFields: nil)!, data: "됨".data(using: .utf8))
        networkManager = NetworkManager(session: urlSession)

        let expectation = XCTestExpectation(description: "expectation fulfill")
        let url = URL(string: "www.naver.com")
        let request = URLRequest(url: url!)
        networkManager.dataTask(request: request) { (result: Result<Task,NetworkError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .invalidStatusCode(400))
                self.urlSession.verifyDataTask(url: url!)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_failure_emptyData() {
        urlSession = MockURLSession(response: HTTPURLResponse(url: URL(string: "www")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: nil)
        networkManager = NetworkManager(session: urlSession)
        
        let expectation = XCTestExpectation(description: "expectation fulfill")
        let url = URL(string: "www.naver.com")
        let request = URLRequest(url: url!)
        networkManager.dataTask(request: request, completion: {(result: Result<Task, NetworkError>) in
            switch result {
            case .success(_):
                XCTest()
            case .failure(let error):
                XCTAssertEqual(error, .emptyData)
            }
        })
    }
}
