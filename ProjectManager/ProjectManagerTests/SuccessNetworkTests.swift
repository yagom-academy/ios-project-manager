
//  NetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/03.


import XCTest
@testable import ProjectManager

class SuccessNetworkTests: XCTestCase {
    var urlSession: MockURLSession!
    var networkManager: NetworkManager<Task>!

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
        urlSession = MockURLSession(response: expectResponse, data: dummyDatas, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "tasks read success")
        
        // when
        networkManager.get(url: readURL) { result in
            switch result {
            //then
            case .success(let data):
                XCTAssertEqual(data, dummyDatas)
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
        guard let responseDummyData = DummyJsonData.responseTask.data else {
            XCTFail("invalid dummyData")
            return
        }
        guard let expectResponse = HTTPURLResponse(url: createURL, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("response is nil")
            return
        }
        let dummyTask = Task(title: "책상정리", content: "집중이 안될땐 역시나 책상정리", deadLine: 1624933807.141012, type: .todo)
        urlSession = MockURLSession(response: expectResponse, data: responseDummyData, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "task post success")

        // when
        networkManager.post(url: createURL, item: dummyTask) { result in
            switch result {
            //then
            case .success(let data):
                do {
                    let task = try JSONDecoder().decode(Task.self, from: data)
                    XCTAssertEqual(task.title, dummyTask.title)
                    expectation.fulfill()
                } catch {
                    XCTFail(String(describing: NetworkError.decodingError))
                }
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
