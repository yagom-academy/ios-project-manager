//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct DetailViewModel {
    private let projectUseCase: ProjectUseCase
    private let content: ProjectEntity
    
    init(projectUseCase: ProjectUseCase, content: ProjectEntity) {
        self.projectUseCase = projectUseCase
        self.content = content
    }
    
    func read() -> ProjectEntity? {
        return projectUseCase.read(projectEntityID: content.id)
    }
    
    func update(_ content: ProjectEntity) {
        projectUseCase.update(projectEntity: content)
        updateHistory(by: content)
    }
    
    func asContent() -> ProjectEntity {
        return content
    }
    
    private func updateHistory(by content: ProjectEntity) {
        let historyEntity = HistoryEntity(
            editedType: .edit,
            title: content.title,
            date: Date().timeIntervalSince1970
        )
        
        projectUseCase.createHistory(historyEntity: historyEntity)
    }
}
