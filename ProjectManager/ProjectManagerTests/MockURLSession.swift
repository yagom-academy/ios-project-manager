//
//  MockURLSession.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/02.
//

import Foundation
import XCTest
@testable import ProjectManager

class MockURLSession: URLSessionProtocol {
    var url: URL?
    var data: Data?
    var response: HTTPURLResponse?
    var error: NetworkError?
    
    init(response: HTTPURLResponse?, data: Data?, error: NetworkError?) {
        self.response = response
        self.data = data
        self.error = error
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = request.url
        if request.httpMethod == "POST" || request.httpMethod == "PUT" {
            self.data = handleData(request.httpBody!)
        }
        return FakeDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
    func verifyDataTask(url: URL) {
        XCTAssertEqual(self.url, url)
    }
    
    private func handleData(_ data: Data) -> Data? {
        let task = try? JSONDecoder().decode(Task.self, from: data)
        task?.id = UUID().uuidString
        let convertedData = try? JSONEncoder().encode(task)
        return convertedData
    }
}

final class FakeDataTask: URLSessionDataTask {
    private let handler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    override func resume() {
        handler()
    }
}
