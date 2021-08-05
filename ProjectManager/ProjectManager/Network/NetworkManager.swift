//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/30.
//

import Foundation

final class NetworkManager<T: Codable> {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url, nil, .get) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(with: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func post(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest =  generateURLRequest(url, item, .post) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(with: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func put(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url, item, .put) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(with: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(url: URL, item: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request: URLRequest = generateURLRequest(url, item, .delete) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(with: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func dataTask(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
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
    
    private func generateURLRequest(_ url: URL, _ item: T?, _ httpMethod: HTTPMethod) -> URLRequest? {
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
