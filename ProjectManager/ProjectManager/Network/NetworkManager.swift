//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/30.
//

import Foundation

final class NetworkManager {
    let session: URLSessionProtocol
    let requestMaker: RequestMaker = RequestMaker()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
//    func get(url: URL, completion: @escaping (Result<[Task], NetworkError>) -> Void) {
//        let request = URLRequest(url: url)
//        dataTask(request: request, completion: completion)
//    }
        
    func post(url: URL, _ item: Task, completion: @escaping (Result<Task, NetworkError>) -> Void) {
        guard let request = requestMaker.generate(url, item, .post) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(request: request, completion: completion)
    }
    
    func put(url: URL, _ item: Task, completion: @escaping (Result<Task, NetworkError>) -> Void) {
        guard let request = requestMaker.generate(url, item, .put) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(request: request, completion: completion)
    }
    
    func dataTask(request: URLRequest, completion: @escaping (Result<Task, NetworkError>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
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
            
            guard let decodedData = try? JSONDecoder().decode(Task.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(decodedData))
        }
        dataTask.resume()
    }
}
