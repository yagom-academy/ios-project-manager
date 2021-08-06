//
//  FailureNetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class FailureNetworkTests: XCTestCase {
    private let dummyURL: URL = URL(string: "www")!
    private let dummyTask: Task = Task(title: "dummy", content: "dummy", deadLine: 123.123, type: .todo)
    private lazy var dummySuccessResponse = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
    private lazy var dummyFailureResponse = HTTPURLResponse(url: dummyURL, statusCode: 404, httpVersion: nil, headerFields: nil)

    private var urlSession: MockURLSession!
    private var networkManager: NetworkManager<Task>!

    func test_when_tasks조회요청_expect_networkError() {
        // given
        urlSession = MockURLSession(response: nil, data: nil, error: NetworkError.error)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "Error exist!")
        
        // when
        networkManager.fetch(url: dummyURL) { result in
            switch result {
            // then
            case .success(_):
                XCTFail("Not intent to success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_task삭제요청_expect_invalidResponseError() {
        // given
        urlSession = MockURLSession(response: nil, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "response is nil")
        
        // when
        networkManager.delete(url: dummyURL, item: dummyTask) { result in
            switch result {
            // then
            case .success(_):
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_task생성요청_expect_invalidStatusCodeError() {
        // given
        urlSession = MockURLSession(response: dummyFailureResponse, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "404 Status Code")
        
        // when
        networkManager.post(url: dummyURL, item: dummyTask) { result in
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
    
    func test_when_task수정요청_expect_emptyDataError() {
        // given
        urlSession = MockURLSession(response: dummySuccessResponse, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "emptyData!")
        
        // when
        networkManager.put(url: dummyURL, item: dummyTask) { result in
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
