//
//  SpyNetworkRepository.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/05.
//

import Foundation
@testable import ProjectManager

final class SpyNetworkRepository: NetworkRepositoryProtocol {

    func fetchTasks(completion: @escaping (Result<[ResponseTask], PMError>) -> Void) { }
    
    func post(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) { }
    
    func patch(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) { }
    
    func delete(task: Task, completion: @escaping (Result<UUID, PMError>) -> Void) { }
}
