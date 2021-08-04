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
    
    func request<T: Codable>(url: URL, _ item: T, httpMethod: HTTPMethod, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = requestMaker.generate(url, item, httpMethod) else {
            completion(.failure(.invalidRequest))
            return
        }
        dataTask(request: request, completion: completion)
    }

    func dataTask<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
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
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(decodedData))
        }
        dataTask.resume()
    }
}
