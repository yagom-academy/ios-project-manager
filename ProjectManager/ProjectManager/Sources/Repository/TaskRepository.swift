//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import UIKit

struct TaskRepository {

    private let decoder = JSONDecoder()

    func fetchTasks(completion: (Result<TaskList, PMError>) -> Void) {
        guard let asset = NSDataAsset(name: "task_list") else {
            completion(.failure(.invalidAsset))
            return
        }

        guard let tasks = try? decoder.decode([Task].self, from: asset.data) else {
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
