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
        
        // post: 직접 구현한 enum의 case
        // POST: 이미 구현되어있는 실제 httpMethod의 내부 상태
        // 등록 요청시에는 requestTask를 encoding한게 httpbody로 들어옴
        // 서버에 잘 등록이 되었다면 등록된 task에 JSON을 data로 반환
        // TODO: requestTask에는 id가 없기 때문에 Task를 encoding해서 보내줘야 함
        if request.httpMethod == "POST" {
            self.data = request.httpBody
        }
        return FakeDataTask {
            completionHandler(self.data, self.response, self.error)
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
