//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import UIKit

struct TaskRepository {

    enum Endpoint {
        static let get: String = "/tasks"
        static let post: String = "/task"
        static let patch: String = "/task"
        static let delete: String = "/task"
    }

    private let base: String = "https://"
    private let session: URLSession = .shared
    private let okResponse: ClosedRange<Int> = (200...299)
    private let decoder: JSONDecoder = JSONDecoder()
    private let encoder: JSONEncoder = JSONEncoder()

    func fetchTasks(completion: @escaping (Result<TaskList, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.get) else { return }

        session.dataTask(with: url) { data, response, error in
            checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let tasks = try? decoder.decode([Task].self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }

                    let todos = tasks.filter { $0.taskState == .todo }
                    let doings = tasks.filter { $0.taskState == .doing }
                    let dones = tasks.filter { $0.taskState == .done }
                    let taskList = TaskList(todos: todos, doings: doings, dones: dones)

                    completion(.success(taskList))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }
    }

    func post(task: Task, completion: @escaping (Result<Task, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.post) else { return }
        guard let httpBody = try? encoder.encode(task) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .post, contentType: .json, body: httpBody)

        session.dataTask(with: request) { data, response, error in
            checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let task = try? decoder.decode(Task.self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }
                    completion(.success(task))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }
    }

    func patch(task: Task, completion: @escaping (Result<Task, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.patch) else { return }
        guard let httpBody = try? encoder.encode(task) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .patch, contentType: .json, body: httpBody)

        session.dataTask(with: request) { data, response, error in
            checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success(let data):
                    guard let task = try? decoder.decode(Task.self, from: data) else {
                        completion(.failure(.decodingFailed))
                        return
                    }
                    completion(.success(task))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }
    }

    func delete(task: Task, completion: @escaping (Result<UUID, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.delete) else { return }
        guard let httpBody = try? encoder.encode(task.id) else {
            completion(.failure(.cannotEncodeToJSON(#function)))
            return
        }

        let request = URLRequest(url: url, method: .delete, contentType: .json, body: httpBody)

        session.dataTask(with: request) { data, response, error in
            checkSessionSucceed(error, response, data) { result in
                switch result {
                case .success:
                    guard let id = task.id else { return }
                    completion(.success(id))
                case .failure(let pmError):
                    completion(.failure(pmError))
                }
            }
        }
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
