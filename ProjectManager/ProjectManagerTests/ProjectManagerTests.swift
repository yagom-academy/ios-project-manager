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
    
    func testPostServerAPI() {
        let networkManager: NetworkManager = NetworkManager()
        let expectation = expectation(description: "PostTest")
        let item = RequestTask(title: "진짜 마지막 시도", content: "입니다", deadLine: 111.3334, type: .done)
        networkManager.post(url: ServerAPI.create.url!, item) { result in
            switch result {
            case .success(let task):
                XCTAssertEqual(item.title, task.title)
            case .failure(let error):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 7)
    }
}
