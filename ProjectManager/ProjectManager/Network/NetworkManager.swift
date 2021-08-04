//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/30.
//

import Foundation

final class NetworkManager {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Codable>(url: URL,
                             _ type: T.Type,
                             _ item: T?,
                             httpMethod: HTTPMethod,
                             completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = generate(url, item, httpMethod) else {
            completion(.failure(.invalidRequest))
            return
        }
        
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
            
            guard let decodedData = try? JSONDecoder().decode(type, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(decodedData))
        }
        dataTask.resume()
    }
    
    private func generate<T: Codable>(_ url: URL, _ item: T?, _ httpMethod: HTTPMethod) -> URLRequest? {
        var request: URLRequest = URLRequest(url: url)
        if httpMethod == .get {
            return request
        }
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
