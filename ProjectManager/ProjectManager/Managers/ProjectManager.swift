//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/17.
//

import Foundation

class ProjectManager {
    private var ProjectListDictionary: [ProjectStatus: [Project]] = [:]

    func create(project: Project) {
        if ProjectListDictionary[project.status] == nil {
            ProjectListDictionary[project.status] = [project]
        } else {
            ProjectListDictionary[project.status]?.append(project)
        }
    }

    func read() -> [Project] {
        return ProjectListDictionary.values.flatMap{ $0 }
    }

    func read(status: ProjectStatus) -> [Project] {
        return ProjectListDictionary[status] ?? []
    }

    func update(project: Project) {
        guard let index = searchIndex(project: project) else {
            return create(project: project)
        }

        guard var projectList = ProjectListDictionary[project.status] else {
            fatalError("해당 프로젝트 리스트가 없음")
        }

        if projectList[index] == project {
            return
        }

        projectList[index] = project
        ProjectListDictionary[project.status] = projectList
    }

    func delete(project: Project) {
        guard let index = searchIndex(project: project),
              var projectList = ProjectListDictionary[project.status] else {
            fatalError("삭제하려는 데이터가 없음")
        }

        projectList.remove(at: index)
        ProjectListDictionary[project.status] = projectList
    }

    private func searchIndex(project: Project) -> Int? {
        guard let index = ProjectListDictionary[project.status]?.firstIndex(where: {$0.id == project.id}) else {
            return nil
        }

        return index
    }
}
