//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

struct ProjectUseCase {
    let repository = ProjectRepository(storageManager: MockStorageManager.shared)
}
