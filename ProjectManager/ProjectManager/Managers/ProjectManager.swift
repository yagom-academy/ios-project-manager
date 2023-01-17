//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import Foundation

struct ProjectManager {
    func create(projectList: inout [Project], project: Project) {
        projectList.append(project)
    }

    func update(projectList: inout [Project], project: Project) {
        let index = searchIndex(projectList: &projectList, project: project)

        if projectList[index].status != project.status {
            projectList[index].status = project.status
        }

        if projectList[index].title != project.title {
            projectList[index].title = project.title
        }

        if projectList[index].description != project.description {
            projectList[index].description = project.description
        }

        if projectList[index].dueDate != project.dueDate {
            projectList[index].dueDate = project.dueDate
        }
    }

    func delete(projectList: inout [Project], project: Project) {
        let index = searchIndex(projectList: &projectList, project: project)

        projectList.remove(at: index)
    }

    private func searchIndex(projectList: inout [Project], project: Project) -> Int {
        guard let index = projectList.firstIndex(where: {$0.id == project.id}) else {
            fatalError()
        }

        return index
    }
}
