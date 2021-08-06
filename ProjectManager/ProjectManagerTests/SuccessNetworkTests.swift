//  NetworkTests.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/03.

import XCTest
@testable import ProjectManager

final class SuccessNetworkTests: XCTestCase {
    private let dummyURL = URL(string: "www")!
    private let dummyDatas = DummyJsonData.tasks.data!
    private let dummyData = DummyJsonData.responseTask.data!
    private let dummyTask = Task(title: "책상정리", content: "집중이 안될땐 역시나 책상정리", deadLine: 1624933807.141012, type: .todo)
    private lazy var dummyResponse = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!

    private var urlSession: MockURLSession!
    private var networkManager: NetworkManager<Task>!

    func test_when_tasks조회요청_expect_taskDecoding성공() {
        // given
        urlSession = MockURLSession(response: dummyResponse, data: dummyData, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "tasks read success")
        
        // when
        networkManager.fetch(url: dummyURL) { result in
            switch result {
            // then
            case .success(let data):
                XCTAssertEqual(data, self.dummyData)
                self.urlSession.verifyDataTask(url: self.dummyURL)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_when_task등록요청_expect_task등록성공() {
        // given
        urlSession = MockURLSession(response: dummyResponse, data: dummyData, error: nil)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation(description: "task post success")

        // when
        networkManager.post(url: dummyURL, item: dummyTask) { result in
            switch result {
            // then
            case .success(let data):
                do {
                    let task = try JSONDecoder().decode(Task.self, from: data)
                    XCTAssertEqual(task.title, self.dummyTask.title)
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
