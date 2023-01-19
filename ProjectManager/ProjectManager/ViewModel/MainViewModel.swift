//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

final class MainViewModel {
    
    private let stateTitles: [String] = ProjectState.allCases.map { state in
        return state.title
    }
    
    private var projectsGroup: [[Project]] = [[], [], []] {
        didSet {
            update(projectsGroup, numberOfProjectByState(projectsGroup))
        }
    }
    
    private var numberOfProjectByState = { (projectGroups: [[Project]]) -> [String] in
        projectGroups.map { String($0.count) }
    }
    
    var update: ([[Project]], [String]) -> Void = { _, _ in }
    
    func generateNewProject() -> Project {
        let newProject =  Project(title: Default.title,
                                  description: Default.description,
                                  date: Default.date,
                                  uuid: UUID())
        
        return newProject
    }
    
    func readTitle(of state: ProjectState) -> String {
        return stateTitles[state.index]
    }
    
    func fetchProjects(of state: ProjectState) -> [Project] {
        return projectsGroup[state.index]
    }
    
    func fetchProject(index: Int, of state: ProjectState) -> Project {
        return projectsGroup[state.index][index]
    }
    
    func add(_ project: Project, in state: ProjectState) {
        projectsGroup[state.index].append(project)
    }
    
    func edit(_ project: Project, of state: ProjectState) {
        projectsGroup[state.index].enumerated().forEach { index, addedProject in
            guard addedProject.uuid == project.uuid else { return }
            projectsGroup[state.index][index] = project
        }
    }
    
    func delete(_ project: Project, of state: ProjectState) {
        projectsGroup[state.index].enumerated().forEach { index, data in
            guard data.uuid == project.uuid else { return }
            projectsGroup[state.index].remove(at: index)
        }
    }
    
    func move(_ project: Project, from currentState: ProjectState, to state: ProjectState) {
        delete(project, of: currentState)
        add(project, in: state)
    }
}

// MARK: - NameSpace
extension MainViewModel {
    
    private enum Default {
        
        static let title = ""
        static let description = ""
        static let date = Date()
    }
}
