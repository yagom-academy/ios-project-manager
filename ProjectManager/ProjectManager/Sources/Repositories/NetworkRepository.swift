//
//  NetworkRepository.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import UIKit
import Network

final class NetworkRepository {

    enum Endpoint {
        static let get: String = "/tasks"
        static let post: String = "/task"
        static let patch: String = "/task"
        static let delete: String = "/task"
    }

    private let base: String = "https://bobian.herokuapp.com"
    private let session: URLSession
    private let okResponse: ClosedRange<Int> = (200...299)

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    init(session: URLSession = .shared) {
        self.session = session
    }

    private func checkSessionSucceed(_ error: Error?,
                                     _ response: URLResponse?,
                                     _ data: Data?,
                                     completion: @escaping (Result<Data, PMError>) -> Void) {
        if let error = error {
            completion(.failure(.requestFailed(error)))
            return
        }

        guard let response = response as? HTTPURLResponse else { return }

        guard okResponse.contains(response.statusCode) else {
            completion(.failure(.failureResponse(response.statusCode)))
            return
        }

        guard let data = data else {
            completion(.failure(.dataNotFound))
            return
        }

        completion(.success(data))
    }
}

// MARK: - TaskNetworkRepositoryProtocol

extension NetworkRepository: TaskNetworkRepositoryProtocol {

    func fetchTasks(completion: @escaping (Result<[ResponseTask], PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.get) else { return }

        session.dataTask(with: url) { [weak self] data, response, error in
            self?.checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let responseTasks = try? self?.decoder.decode([ResponseTask].self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }
                    completion(.success(responseTasks))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }.resume()
    }

    func post(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.post) else { return }
        guard let httpBody = try? encoder.encode(PostTask(by: task)) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .post, contentType: .json, body: httpBody)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let responseTask = try? self?.decoder.decode(ResponseTask.self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }
                    completion(.success(responseTask))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }.resume()
    }

    func patch(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.patch) else { return }
        guard let httpBody = try? encoder.encode(PatchTask(by: task)) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .patch, contentType: .json, body: httpBody)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let responseTask = try? self?.decoder.decode(ResponseTask.self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }
                    completion(.success(responseTask))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }.resume()
    }

    func delete(task: Task, completion: @escaping (Result<UUID, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.delete) else { return }
        guard let httpBody = try? encoder.encode(DeleteTask(by: task)) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .delete, contentType: .json, body: httpBody)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success:
                    completion(.success(task.id))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }.resume()
    }
}
