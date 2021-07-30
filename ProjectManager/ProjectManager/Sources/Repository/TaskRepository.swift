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
    }

    private let base: String = "https://"
    private let session: URLSession = .shared
    private let okResponse = 200...299

    func fetchTasks(completion: @escaping (Result<TaskList, PMError>) -> Void) {
        guard let url = URL(string: base + Endpoint.get) else { return }

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
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

            guard let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }

            let todos = tasks.filter { $0.taskState == .todo }
            let doings = tasks.filter { $0.taskState == .doing }
            let dones = tasks.filter { $0.taskState == .done }
            let taskList = TaskList(todos: todos, doings: doings, dones: dones)

            completion(.success(taskList))
        }
    }
}
