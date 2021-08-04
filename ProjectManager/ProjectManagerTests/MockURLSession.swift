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
    var url: URL!
    var data: Data?
    var response: HTTPURLResponse
    
    init(response: HTTPURLResponse, data: Data?) {
        self.response = response
        self.data = data
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = request.url
        
        return FakeDataTask {
            completionHandler(self.data, self.response, nil)
        }
    }
    
    func verifyDataTask(url: URL) {
        XCTAssertEqual(self.url, url)
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
