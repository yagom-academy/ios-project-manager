//
//  NetworkRepositoryTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class NetworkRepositoryTests: XCTestCase {

    private var sutNetworkRepository: NetworkRepository!
    private var coreDataRepository: CoreDataRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        sutNetworkRepository = NetworkRepository(session: urlSession)

        coreDataRepository = CoreDataRepository(coreDataStack: MockCoreDataStack())
    }

    override func tearDownWithError() throws {
        MockURLProtocol.loadingHandler = nil
        coreDataRepository = nil
        try super.tearDownWithError()
    }

    func test_fetchTasks해야징() throws {
        guard let today: TimeInterval = Date().date?.timeIntervalSince1970 else { return }
        let todoTask = ResponseTask(id: UUID(), title: "ABC", body: "123", dueDate: Int(today), state: .todo)
        let expectedHTTPBodyResponse = try JSONEncoder().encode([todoTask])

        setLoadingHandler(true, expectedHTTPBodyResponse)
        
        let expectation = XCTestExpectation(description: "Fetch test")
        
        sutNetworkRepository.fetchTasks { result in
            switch result {
            case .success(let responseTasks):
                let taskList = TaskList(context: self.coreDataRepository.coreDataStack.context, responseTasks: responseTasks)
                XCTAssertEqual(taskList[.todo].first?.id, todoTask.id)
                XCTAssertEqual(taskList[.todo].first?.title, todoTask.title)
                XCTAssertEqual(taskList[.todo].first?.body, todoTask.body)
                XCTAssertEqual(taskList[.todo].first?.dueDate, Date(timeIntervalSince1970: Double(today)))
                XCTAssertEqual(taskList[.todo].first?.taskState, todoTask.state)
                expectation.fulfill()
            case .failure:
                XCTFail("Fetch 하지 못하였습니다.")
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}

// MARK: - Private methods for testing

extension NetworkRepositoryTests {
    private func setLoadingHandler(_ networkShouldSuccess: Bool, _ data: Data) {
        MockURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse

            if networkShouldSuccess {
                response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            } else {
                response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
                return (response, nil)
            }
        }
    }

//    private func setTestEnvironment<HTTPBody: Encodable>(networkShouldSuccess: Bool,
//                                                         httpBody: HTTPBody,
//                                                         expectationTimeout: Double,
//                                                         test: (HTTPBody, XCTestExpectation) -> Void) {
//
//    }
//
//    private func setTestEnvironment<HTTPBody: Decodable>(networkShouldSuccess: Bool,
//                                                         httpBody: HTTPBody? = nil,
//                                                         expectationTimeout: Double,
//                                                         test: (HTTPBody, XCTestExpectation) -> Void) throws {
//        guard let encodedMockResponseTask = try createEncodedMockResponseTask() else {
//            XCTFail("인코딩된 mockResponseTask를 가져오지 못했습니다.")
//            return
//        }
//
//        let expectation = XCTestExpectation(description: "Loading...")
//        setLoadingHandler(networkShouldSuccess, encodedMockResponseTask)
//        test(encodedMockResponseTask, expectation)
//    }
    
    private func createEncodedMockResponseTask() throws -> Data? {
        guard let today = Date().date?.timeIntervalSince1970 else {
            XCTFail("날짜를 가져오지 못했습니다.")
            return nil
        }
        let mockResponseTask = ResponseTask(id: UUID(), title: "Todo task", body: "Yahoo", dueDate: Int(today), state: .todo)
        let encoded = try JSONEncoder().encode(mockResponseTask)
        
        return encoded
    }
    
//    private func createEncodedMockTaskList() throws -> Data {
//        let todoTask = try taskManger.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)
//        let doingTask = try taskManger.create(title: "가나다", body: "이히잇", dueDate: Date(), state: .doing)
//        let doneTask = try taskManger.create(title: "하이용", body: "옹헤야", dueDate: Date(), state: .done)
//        let taskList = TaskList(todos: [todoTask], doings: [doingTask], dones: [doneTask])
//        return try JSONEncoder().encode(taskList)
//    }
}
