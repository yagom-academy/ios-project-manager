//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct RegistrationViewModel {
    func registerate(title: String, date: Date, description: String) {
        var currentProjects = MockStorageManager.shared.read().value
        currentProjects
            .append(
                ProjectContent(
                    title: title,
                    deadline: date,
                    description: description
                )
            )
        
        MockStorageManager.shared.create(projectContents: currentProjects)
    }
}
