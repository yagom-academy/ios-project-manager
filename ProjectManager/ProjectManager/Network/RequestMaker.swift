//
//  RequestBodyMaker.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/30.
//

import Foundation

enum ProjectManagerError: Error {
    case invalidURL
}

struct RequestMaker {
    func generate<T: Codable>(_ url: URL, _ item: T, _ httpMethod: HTTPMethod) -> URLRequest? {
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONEncoder().encode(item)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        return request
    }
}
