//
//  NetworkTest2.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/03.
//

import XCTest
@testable import ProjectManager

class RealNetworkTests: XCTestCase {
    func test_get() {
        let jsonString = """
            [
                 {
                     "title" : "책상정리",
                     "description" : "집중이 안될땐 역시나 책상정리",
                     "dueDate" : 1624933807.141012,
                     "status" : "TODO",
                     "id" : "1731F34B-C6B5-40DD-B07E-6CBDC444382C"
                 },
                 {
                     "title" : "일기쓰기",
                    "description" : "집중이 안될땐 역시나 일기쓰기",
                    "dueDate" : 162493123132.141012,
                    "status" : "DOING",
                    "id" : "1731F34B-C6B5-40DD-NJ95-6CBDC444382C"
                 }
            ]
        """
        
        let expectation =  XCTestExpectation()
        
        let emptyTasks: [Task] = []
        let mockURLSession: MockURLSession = MockURLSession(response: HTTPURLResponse(url: ServerAPI.read.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: jsonString.data(using: .utf8))
        let networkManager = NetworkManager(session: mockURLSession)
        
        networkManager.request(url: ServerAPI.read.url!, emptyTasks, httpMethod: .get) { result in
            switch result {
            case .success(let tasks):
                XCTAssertNil(tasks)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
