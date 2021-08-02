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
        let expectation1 = expectation(description: "GetTest")
        networkManager.get(url: ServerAPI.read.url!) { result in
            switch result {
            case .success(let tasks):
                XCTAssertNotNil(tasks)
            case .failure(let error):
                XCTFail()
            }
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 5)
    }
    
    func testPostServerAPI() {
        let networkManager: NetworkManager = NetworkManager()
        let expectation2 = expectation(description: "PostTest")
        let item = RequestTask(title: "진짜 마지막 시도", content: "입니다", deadLine: 111.3334, type: .done)
        networkManager.post(url: ServerAPI.create.url!, item) { result in
            switch result {
            case .success(let task):
                XCTAssertEqual(item.title, task.title)
            case .failure(let error):
                XCTFail()
            }
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 7)
    }
    
    func testPutServerAPI() {
        let networkManager: NetworkManager = NetworkManager()
        let id = "38A26C85-A2EB-471C-BF12-D455AF1FA508"
        let expectation3 = expectation(description: "PostTest")
        let item = RequestTask(title: "수정1", content: "수정111", deadLine: 12345532.233334, type: .todo)
        networkManager.put(url: ServerAPI.update(id: id).url!, item) { result in
            switch result {
            case .success(let task):
                XCTAssertEqual(item.title, task.title)
            case .failure(let error):
                XCTFail()
            }
            expectation3.fulfill()
        }
        wait(for: [expectation3], timeout: 7)
    }
}
