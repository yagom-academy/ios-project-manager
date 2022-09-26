//
//  TemporaryProjectRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/19.
//

struct TemporaryProjectRepository: ProjectRepository {
    private var projectModels: [ProjectModel]
    
    init(projectModels: [ProjectModel]) {
        self.projectModels = projectModels
    }
    
    mutating func create(data: ProjectModel) {
        projectModels.append(data)
    }
    
    func read() -> [ProjectModel] {
        return projectModels
    }
    
    mutating func update(id: String,
                         data: ProjectModel) {
        projectModels.indices.forEach {
            projectModels[$0] = projectModels[$0].id == id ? data : projectModels[$0]
        }
    }
    
    mutating func delete(id: String) {
        projectModels.removeAll(where: { $0.id == id })
    }
}
