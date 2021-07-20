//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/20.
//

import UIKit

struct TaskRepository {

    private let decoder = JSONDecoder()

    func fetchTasks(completion: (Result<[Task], PMError>) -> Void) {
        guard let asset = NSDataAsset(name: "tasks") else {
            completion(.failure(.invalidAsset))
            return
        }

        guard let tasks = try? decoder.decode([Task].self, from: asset.data) else {
            completion(.failure(.decodingFailed))
            return
        }

        completion(.success(tasks))
    }
}
