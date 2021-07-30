//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 오인탁 on 2021/07/30.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {

    func test() {
        let networkManager: NetworkManager = NetworkManager()
        let expectation = expectation(description: "GetTest")
        networkManager.get(url: ServerAPI.read.url!) { result in
            switch result {
            case .success(let tasks):
                XCTAssertNotNil(tasks)
            case .failure(let error):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
