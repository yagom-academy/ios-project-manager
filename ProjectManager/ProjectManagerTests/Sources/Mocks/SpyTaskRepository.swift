//
//  SpyTaskRepository.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/05.
//

import Foundation
@testable import ProjectManager

final class SpyTaskRepository: TaskRepositoryProtocol {

    func fetchTasks(completion: @escaping (Result<TaskList, PMError>) -> Void) { }
    
    func post(task: Task, completion: @escaping (Result<Task, PMError>) -> Void) { }
    
    func patch(task: Task, completion: @escaping (Result<Task, PMError>) -> Void) { }
    
    func delete(task: Task, completion: @escaping (Result<UUID, PMError>) -> Void) { }
}
