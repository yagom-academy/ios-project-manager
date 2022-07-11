//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

struct RegistrationViewModel {
    func registerate(title: String, date: Date, description: String) {
        MockStorageManager.shared.creat(
            projectContent: ProjectContent(
                ProjectItem(id: UUID(),
                            status: ProjectStatus.todo.string,
                            title: title,
                            deadline: date,
                            description: description
                           )
            )
        )
    }
}
