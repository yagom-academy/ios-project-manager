//
//  TaskNetworkRepositoryProtocol.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/05.
//

import Foundation

protocol TaskNetworkRepositoryProtocol: AnyObject {

    func fetchTasks(completion: @escaping (Result<[ResponseTask], PMError>) -> Void)
    func post(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void)
    func patch(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void)
    func delete(task: Task, completion: @escaping (Result<UUID, PMError>) -> Void)
}
