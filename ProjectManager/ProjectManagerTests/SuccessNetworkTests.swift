
//  NetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/03.


import XCTest
@testable import ProjectManager

class SuccessNetworkTests: XCTestCase {
    var urlSession: MockURLSession!
    var networkManager: NetworkManager!

    func test_when_tasks조회요청_expect_taskDecoding성공() {
        // given
        guard let readURL = ServerAPI.read.url else {
            XCTFail("URLError")
            return
        }
        guard let dummyDatas = DummyJsonData.tasks.data else {
            XCTFail("invalid dummyData")
            return
        }
        guard let expectResponse = HTTPURLResponse(url: readURL, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("response is nil")
            return
        }
        let expectTasks = try? JSONDecoder().decode([Task].self, from: dummyDatas)
        urlSession = MockURLSession(response: expectResponse, data: dummyDatas, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "tasks read success")
        
        // when
        networkManager.request(url: readURL, [Task].self, nil, httpMethod: .get) { result in
            switch result {
            // then
            case .success(let tasks):
                XCTAssertEqual(expectTasks, tasks)
                self.urlSession.verifyDataTask(url: readURL)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_task등록요청_expect_task등록성공() {
        // given
        guard let createURL = ServerAPI.create.url else {
            XCTFail("URLError")
            return
        }
        guard let expectResponse = HTTPURLResponse(url: createURL, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("response is nil")
            return
        }
        let requestTask = RequestTask(title: "title", content: "content", deadLine: 123.0, type: .todo)
        urlSession = MockURLSession(response: expectResponse, data: nil, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "task post success")
        
        // when
        networkManager.request(url: createURL, RequestTask.self, requestTask, httpMethod: .post) { result in
            switch result {
            // then
            case .success(let task):
                XCTAssertEqual(requestTask.title, task.title)
                /*
                 task가 현재 RequestTask타입이라 id 접근 불가
                 Task타입으로 통합해야하는지? -> id를 빼?, 옵셔널?
                 Taskable 프로토콜 생성?
                 */
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
