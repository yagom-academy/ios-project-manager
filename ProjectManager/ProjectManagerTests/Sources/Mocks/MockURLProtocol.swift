//
//  MockURLProtocol.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/05.
//

import XCTest

final class MockURLProtocol: URLProtocol {

    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.loadingHandler else {
            XCTFail("Loading handler가 설정되지 않았습니다.")
            return
        }
        let (response, data) = handler(request)

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
