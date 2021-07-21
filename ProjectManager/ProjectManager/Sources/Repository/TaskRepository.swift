//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by Ryan-Son, duckbok on 2021/07/20.
//

import UIKit

struct TaskRepository {

    private let decoder = JSONDecoder()

    func fetchTasks(completion: (Result<TaskList, PMError>) -> Void) {
        guard let asset = NSDataAsset(name: "task_list") else {
            completion(.failure(.invalidAsset))
            return
        }

        guard let taskList = try? decoder.decode(TaskList.self, from: asset.data) else {
            completion(.failure(.decodingFailed))
            return
        }

        completion(.success(taskList))
    }
}
