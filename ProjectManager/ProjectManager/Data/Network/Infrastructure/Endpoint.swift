//
//  Endpoint.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

final class Endpoint {
  private let baseURL: String
  private let path: String
  private let method: HTTPMethod
  private let queries: [String: Any]
  private let headers: [String: String]
  private let payload: Data?
  
  init(
    baseURL: String,
    path: String,
    method: HTTPMethod,
    queries: [String: Any] = [:],
    headers: [String: String] = [:],
    payload: Data? = nil
  ) {
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.queries = queries
    self.headers = headers
    self.payload = payload
  }
  
  func create() throws -> URLRequest {
    let url = try createURL()
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    headers.forEach {
      request.addValue($0.value, forHTTPHeaderField: $0.key)
    }
    
    if method != .get, let httpBody = payload {
      request.httpBody = httpBody
    }
    
    return request
  }
  
  private func createURL() throws -> URL {
    let urlString = baseURL + path
    var component = URLComponents(string: urlString)
    component?.queryItems = queries.map {
      URLQueryItem(name: $0.key, value: "\($0.value)")
    }
    
    guard let url = component?.url else {
      throw EndpointError.createURLFailure
    }
    
    return url
  }
}
