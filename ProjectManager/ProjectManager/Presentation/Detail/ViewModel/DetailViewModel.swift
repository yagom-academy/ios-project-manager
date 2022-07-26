//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct DetailViewModel {
    private let content: ProjectEntity
    
    init(content: ProjectEntity) {
        self.content = content
    }
    
    func read() -> ProjectEntity? {
        return ProjectUseCase().read(id: content.id)
    }
    
    func update(_ content: ProjectEntity) {
        ProjectUseCase().update(projectContent: content)
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
        
        ProjectUseCase().createHistory(historyEntity: historyEntity)
    }
}
