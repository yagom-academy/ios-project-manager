
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
        //given
        guard let readURL = ServerAPI.read.url else {
            XCTFail()
            return
        }
        guard let dummyDatas = DummyJsonData.tasks.data else {
            XCTFail()
            return
        }
        guard let expectResponse = HTTPURLResponse(url: readURL, statusCode: 200, httpVersion: nil, headerFields: nil) else { XCTFail()
            return
        }
        let expectTasks = try? JSONDecoder().decode([Task].self, from: dummyDatas)
        urlSession = MockURLSession(response: expectResponse, data: dummyDatas)
        networkManager = NetworkManager(session: urlSession)
        let expectation = XCTestExpectation()
        
        //when
        networkManager.request(url: readURL, [Task].self, nil, httpMethod: .get) { result in
            switch result {
            //then
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
}
