//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct RegistrationViewModel {
    func registrate(title: String, date: Date, description: String) {
        var currentProjects = ProjectUseCase().read().value
        currentProjects
            .append(
                ProjectContent(
                    title: title,
                    deadline: date,
                    description: description
                )
            )
        
        ProjectUseCase().create(projectContents: currentProjects)
    }
}
