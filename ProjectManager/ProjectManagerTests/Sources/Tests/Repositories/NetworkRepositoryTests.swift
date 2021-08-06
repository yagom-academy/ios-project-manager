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
        let configuration: URLSessionConfiguration = .default
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

    func test_fetchTasks를통해_서버에저장된task들을가져올수있다() throws {
        guard let today: TimeInterval = Date().date?.timeIntervalSince1970 else { return }
        let mockResponseTask = ResponseTask(id: UUID(), title: "ABC", body: "123", dueDate: Int(today), state: .todo)
        let expectedHTTPBodyResponse = try JSONEncoder().encode([mockResponseTask])

        setLoadingHandler(true, expectedHTTPBodyResponse)
        
        let expectation = XCTestExpectation(description: "Fetch test")
        sutNetworkRepository.fetchTasks { result in
            switch result {
            case .success(let responseTasks):
                let taskList = TaskList(context: self.coreDataRepository.coreDataStack.context, responseTasks: responseTasks)
                XCTAssertEqual(taskList[.todo].first?.id, mockResponseTask.id)
                XCTAssertEqual(taskList[.todo].first?.title, mockResponseTask.title)
                XCTAssertEqual(taskList[.todo].first?.body, mockResponseTask.body)
                XCTAssertEqual(taskList[.todo].first?.dueDate, Date(timeIntervalSince1970: Double(today)))
                XCTAssertEqual(taskList[.todo].first?.taskState, mockResponseTask.state)
                expectation.fulfill()
            case .failure:
                XCTFail("Fetch 하지 못하였습니다.")
            }
        }
        wait(for: [expectation], timeout: 2)
    }

    func test_post에task를전달하면_전달한task를서버DB에저장할수있다() throws {
        let expectedID = UUID()
        let expectedTitle: String = "POST"
        let expectedBody: String = "TEST"
        guard let expectedDueDate = Date().date else { return }
        let expectedState: Task.State = .todo
        let task = Task(context: coreDataRepository.coreDataStack.context,
                        id: expectedID,
                        title: expectedTitle,
                        body: expectedBody,
                        dueDate: expectedDueDate,
                        state: expectedState)
        let postTask = PostTask(by: task)
        let expectedResponseTask = ResponseTask(id: expectedID,
                                                title: expectedTitle,
                                                body: expectedBody,
                                                dueDate: Int(expectedDueDate.timeIntervalSince1970),
                                                state: expectedState)
        let expectedHTTPBodyResponse = try JSONEncoder().encode(postTask)

        setLoadingHandler(true, expectedHTTPBodyResponse)
        
        let expectation = XCTestExpectation(description: "Post test")
        sutNetworkRepository.post(task: task) { result in
            switch result {
            case .success(let responseTask):
                XCTAssertEqual(responseTask.id, expectedResponseTask.id)
                XCTAssertEqual(responseTask.title, expectedResponseTask.title)
                XCTAssertEqual(responseTask.body, expectedResponseTask.body)
                XCTAssertEqual(responseTask.dueDate, expectedResponseTask.dueDate)
                XCTAssertEqual(responseTask.state, expectedResponseTask.state)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Post에 실패하였습니다. \(error)")
            }
        }
        wait(for: [expectation], timeout: 2)
    }

    func test_patch를통해수정된task를전달하면_서버DB에저장된task를수정할수있다() throws {
        let expectedID = UUID()
        let expectedTitle: String = "PATCH"
        let expectedBody: String = "TEST"
        guard let expectedDueDate = Date().date else { return }
        let expectedState: Task.State = .todo
        let task = Task(context: coreDataRepository.coreDataStack.context,
                        id: expectedID,
                        title: expectedTitle,
                        body: expectedBody,
                        dueDate: expectedDueDate,
                        state: expectedState)
        let patchTask = PatchTask(by: task)
        let expectedResponseTask = ResponseTask(id: expectedID,
                                                title: expectedTitle,
                                                body: expectedBody,
                                                dueDate: Int(expectedDueDate.timeIntervalSince1970),
                                                state: expectedState)
        let expectedHTTPBodyResponse = try JSONEncoder().encode(patchTask)

        setLoadingHandler(true, expectedHTTPBodyResponse)
        
        let expectation = XCTestExpectation(description: "Patch test")
        sutNetworkRepository.patch(task: task) { result in
            switch result {
            case .success(let responseTask):
                XCTAssertEqual(responseTask.id, expectedResponseTask.id)
                XCTAssertEqual(responseTask.title, expectedResponseTask.title)
                XCTAssertEqual(responseTask.body, expectedResponseTask.body)
                XCTAssertEqual(responseTask.dueDate, expectedResponseTask.dueDate)
                XCTAssertEqual(responseTask.state, expectedResponseTask.state)
                expectation.fulfill()
            case .failure:
                XCTFail("Patch에 실패하였습니다.")
            }
        }
        wait(for: [expectation], timeout: 2)
    }

    func test_delete를통해삭제할task를전달하면_서버DB에저장된task를삭제할수있다() throws {
        let expectedID = UUID()
        guard let dueDate = Date().date else { return }
        let task = Task(context: coreDataRepository.coreDataStack.context,
                        id: expectedID,
                        title: "DELETE",
                        body: "TEST",
                        dueDate: dueDate,
                        state: .done)
        let deleteTask = DeleteTask(by: task)
        let expectedHTTPBodyResponse = try JSONEncoder().encode(deleteTask)

        setLoadingHandler(true, expectedHTTPBodyResponse)
        
        let expectation = XCTestExpectation(description: "Delete test")
        sutNetworkRepository.delete(task: task) { result in
            switch result {
            case .success(let responseStatusCode):
                XCTAssertEqual(responseStatusCode, 204)
                expectation.fulfill()
            case .failure:
                XCTFail("Delete에 실패하였습니다.")
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
                if request.httpMethod == URLRequest.HTTPMethod.delete.rawValue {
                    response = HTTPURLResponse(url: request.url!, statusCode: 204, httpVersion: nil, headerFields: nil)!
                    return (response, nil)
                } else if request.httpMethod == URLRequest.HTTPMethod.post.rawValue {
                    response = HTTPURLResponse(url: request.url!, statusCode: 201, httpVersion: nil, headerFields: nil)!
                    return (response, data)
                } else {
                    response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    return (response, data)
                }
            } else {
                response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
                return (response, nil)
            }
        }
    }
}
