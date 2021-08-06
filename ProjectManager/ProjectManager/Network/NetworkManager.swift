//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/30.
//

import Foundation

final class NetworkManager<T: Codable> {
    private let session: URLSessionProtocol
    private let okResponseStatusCode: ClosedRange<Int> = (200...299)
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request: URLRequest = URLRequest(url: url)
        retrieveData(with: request, completion: completion)
    }
    
    func post(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url: url,
                                                           item: item,
                                                           method: .delete,
                                                           headers: [.contentType(key: HTTPHeader.applicationJson)]) else {
            completion(.failure(.invalidRequest))
            return
        }
        retrieveData(with: request, completion: completion)
    }
    
    func put(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url: url,
                                                           item: item,
                                                           method: .delete,
                                                           headers: [.contentType(key: HTTPHeader.applicationJson)]) else {
            completion(.failure(.invalidRequest))
            return
        }
        retrieveData(with: request, completion: completion)
    }
    
    func delete(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url: url,
                                                           item: item,
                                                           method: .delete,
                                                           headers: [.contentType(key: HTTPHeader.applicationJson)]) else {
            completion(.failure(.invalidRequest))
            return
        }
        retrieveData(with: request, completion: completion)
    }
    
    private func retrieveData(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard self.okResponseStatusCode.contains(response.statusCode) else {
                completion(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
                
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    private func generateURLRequest(url: URL, item: T?, method: HTTPMethod, headers: [HTTPHeader]?) -> URLRequest? {
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "\(method)"
        headers?.forEach {
            $0.header.forEach { field, value in
                request.addValue(value, forHTTPHeaderField: field)
            }
        }
        do {
            let data = try JSONEncoder().encode(item)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return request
    }
}
