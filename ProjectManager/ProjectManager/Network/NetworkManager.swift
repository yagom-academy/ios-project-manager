//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/30.
//

import Foundation

enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete
    
    var description: String {
        return self.rawValue.uppercased()
    }
}

enum ServerAPI {
    static let baseURL = "https://projectmanager-great.herokuapp.com/tasks"
    
    case create
    case read
    case update(id: String)
    case delete(id: String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .read:
            return .get
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }

    var url: URL? {
        switch self {
        case .create:
            return URL(string: Self.baseURL)
        case .read:
            return URL(string: Self.baseURL)
        case .update(let id):
            return URL(string: Self.baseURL + "/" + id)
        case .delete(let id):
            return URL(string: Self.baseURL + "/" + id)
        }
    }
}

class NetworkManager {
    let session: URLSession
    let requestBodyMaker: RequestBodyMaker = RequestBodyMaker()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (Result<[Task], Error>) -> Void) {
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(error!))
                return
            }
            
            if let data = data,
               let tasks = try? JSONDecoder().decode([Task].self, from: data) {
                completion(.success(tasks))
                return
            }
            completion(.failure(fatalError()))
        }
        dataTask.resume()
    }
    
    func post<T: Codable>(url: URL, _ item: T, completion: @escaping (Result<Task, Error>) -> Void) {
        guard let request = requestBodyMaker.postJsonRequest(url, item, .post) else {
            completion(.failure(fatalError()))
        }
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(fatalError()))
                return
            }
            
            if let data = data, let task = try? JSONDecoder().decode(Task.self, from: data) {
                completion(.success(task))
                return
            }
            completion(.failure(fatalError()))
        }
        dataTask.resume()
    }
}
