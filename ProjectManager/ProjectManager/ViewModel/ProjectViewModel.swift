//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/23.
//

import Foundation

struct ProjectViewModel {
    private var projectList: [Project] = []
    
    func search(state: ProjectState) -> [Project] {
        let list = projectList.filter { $0.state == state }
        
        return list
    }
    
    mutating func create(project: Project) {
        projectList.append(project)
    }
    
    mutating func update(project: Project) {
        guard let firstIndex = projectList.firstIndex(where: { $0.id == project.id }) else { return }
        
        projectList[firstIndex] = project
    }
    
    mutating func delete(state: ProjectState, at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let list = search(state: state)
        guard let target = list[safe:index],
              let firstIndex = projectList.firstIndex(where: { $0.id == target.id }) else { return }
   
        projectList.remove(at: firstIndex)
    }
    
    mutating func move(project: Project, to state: ProjectState) {
        guard let firstIndex = projectList.firstIndex(where: { $0.id == project.id }) else { return }
        
        var item = projectList.remove(at: firstIndex)
        item.state = state
        projectList.append(item)
    }
}
