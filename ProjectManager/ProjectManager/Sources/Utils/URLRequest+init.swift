//
//  URLRequest+init.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

import Foundation

extension URLRequest {

    enum HTTPMethod: String {
        case get
        case post
        case patch
        case delete
    }

    enum ContentType: String {
        static let description = "Content-Type"
        case json = "application/json"
    }

    init(url: URL, method: HTTPMethod, contentType: ContentType, body: Data) {
        self.init(url: url)
        self.httpMethod = method.rawValue.uppercased()
        self.setValue(contentType.rawValue, forHTTPHeaderField: ContentType.description)
        self.httpBody = body
    }
}
