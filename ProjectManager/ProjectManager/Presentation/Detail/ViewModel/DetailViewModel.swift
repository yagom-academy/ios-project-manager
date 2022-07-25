//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct DetailViewModel {
    private let content: ProjectContent
    
    init(content: ProjectContent) {
        self.content = content
    }
    
    func read() -> ProjectContent? {
        return ProjectUseCase().read(id: content.id)
    }
    
    func update(_ content: ProjectContent) {
        ProjectUseCase().update(projectContent: content)
        updateHistory(by: content)
    }
    
    func asContent() -> ProjectContent {
        return content
    }
    
    private func updateHistory(by content: ProjectContent) {
        let historyEntity = HistoryEntity(
            editedType: .edit,
            title: content.title,
            date: Date().timeIntervalSince1970
        )
        
        ProjectUseCase().createHistory(historyEntity: historyEntity)
    }
}
