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
    var networkManager: NetworkManager!

    func test_when_tasks조회요청_expect_networkError() {
        //given
        urlSession = MockURLSession(response: nil, data: nil, error: NetworkError.error)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation()
        
        //when
        networkManager.request(url: URL(string: "www")!, [Task].self, nil, httpMethod: .get) { result in
            switch result {
            //then
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}
