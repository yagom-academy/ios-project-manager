//
//  FailureNetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/04.
//

import XCTest
@testable import ProjectManager

class FailureNetworkTests: XCTestCase {
    var urlSession: MockURLSession!
    var networkManager: NetworkManager<Task>!

    func test_when_tasks조회요청_expect_networkError() {
        // given
        urlSession = MockURLSession(response: nil, data: nil, error: NetworkError.error)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "Error exist!")
        
        // when
        networkManager.get(url: URL(string: "www")!) { result in
            switch result {
            //then
            case .success(_):
                XCTFail("Not intent to success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_tasks조회요청_expect_invalidResponseError() {
        // given
        urlSession = MockURLSession(response: nil, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "response is nil")
        
        // when
        networkManager.get(url: URL(string: "www")!) { result in
            switch result {
            //then
            case .success(_):
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_tasks조회요청_expect_invalidStatusCodeError() {
        // given
        guard let expectResponse = HTTPURLResponse(url: URL(string: "www")!, statusCode: 404, httpVersion: nil, headerFields: nil) else {
            XCTFail("response is nil")
            return
        }
        urlSession = MockURLSession(response: expectResponse, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "404 Status Code")
        
        // when
        networkManager.get(url: URL(string: "www")!) { result in
            switch result {
            case .success(_):
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidStatusCode(404))
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_tasks조회요청_expect_emptyDataError() {
        // given
        guard let readURL = ServerAPI.read.url else {
            XCTFail("URLError")
            return
        }
        guard let expectResponse = HTTPURLResponse(url: readURL, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("response is nil")
            return
        }
        urlSession = MockURLSession(response: expectResponse, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "emptyData!")
        
        // when
        networkManager.get(url: readURL) { result in
            switch result {
            // then
            case .success(_):
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.emptyData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
