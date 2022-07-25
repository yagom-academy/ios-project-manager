//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct RegistrationViewModel {
    func registrate(title: String, date: Date, body: String) {
        let newProject = ProjectContent(
            title: title,
            deadline: date,
            body: body
        )
        
        ProjectUseCase().create(projectContent: newProject)
        registrateHistory(by: newProject)
    }
    
    private func registrateHistory(by content: ProjectContent) {
        let historyEntity = HistoryEntity(
            editedType: .register,
            title: content.title,
            date: Date().timeIntervalSince1970
        )
        
        ProjectUseCase().createHistory(historyEntity: historyEntity)
    }
}
