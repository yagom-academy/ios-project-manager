//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

final class MainViewModel {
    
    private let networkMonitor: NetworkMonitor = NetworkMonitor()
    private let localDataManager: some ProjectCRUDable = CoreDataManager()
    private let remoteDataManager: some ProjectRemoteCRUDable = FireBaseStoreManager()
    
    private let stateTitles: [String] = ProjectState.allCases.map { state in
        return state.title
    }
    
    private var projectsGroup: [[Project]] = [[], [], []] {
        didSet {
            updateProjects(projectsGroup, numberOfProjectInState(projectsGroup))
        }
    }
    
    private var numberOfProjectInState = { (projectGroups: [[Project]]) -> [String] in
        return projectGroups.map { projects in
            String(projects.count)
        }
    }
    
    private(set) var networkIsConnected: Bool = true {
        didSet {
            updateNetwork(networkIsConnected)
        }
    }
    
    private(set) var projectHistories: [ProjectHistory] = []
    
    var updateProjects: ([[Project]], [String]) -> Void = { _, _ in }
    var updateNetwork: (Bool) -> Void = { _ in }
    
    init() {
        networkMonitor.delegate = self
        networkMonitor.monitorNetworkChanges()
    }
    
    func initialFetchSavedProjects() {
        localDataManager.read { result in
            switch result {
            case .success(let projectViewModels):
                var initialProjectsGroup: [[Project]] = [[], [], []]
                
                projectViewModels.forEach { projectViewModel in
                    let stateIndex = projectViewModel.state.index
                    let project = projectViewModel.project
                    
                    initialProjectsGroup[stateIndex].append(project)
                }
                
                self.projectsGroup = initialProjectsGroup
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func generateNewProject() -> Project {
        let newProject =  Project(title: Default.title,
                                  detail: Default.detail,
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
    
    func fetchProject(index: Int, of state: ProjectState) -> Project? {
        guard index < projectsGroup[state.index].count else {
            return nil
        }
        
        return projectsGroup[state.index][index]
    }
    
    func delete(_ project: Project, of state: ProjectState) {
        projectsGroup[state.index].enumerated().forEach { index, data in
            guard data.uuid == project.uuid else { return }
            
            projectsGroup[state.index].remove(at: index)
            localDataManager.delete(ProjectViewModel(project: project, state: state))
            remoteDataManager.delete(ProjectViewModel(project: project, state: state))
            
            let projectHistory = ProjectHistory(Project: project, change: .remove(from: state))
            projectHistories.insert(projectHistory, at: 0)
        }
    }
    
    func move(_ project: Project, from currentState: ProjectState, to state: ProjectState) {
        projectsGroup[currentState.index].enumerated().forEach { index, data in
            guard data.uuid == project.uuid else { return }
            
            projectsGroup[currentState.index].remove(at: index)
            projectsGroup[state.index].append(project)
            localDataManager.update(ProjectViewModel(project: project, state: state))
            remoteDataManager.update(ProjectViewModel(project: project, state: state))
            
            let projectHistory = ProjectHistory(Project: project,
                                                change: .move(from: currentState, to: state))
            projectHistories.insert(projectHistory, at: 0)
        }
    }
    
    func save(_ project: Project, in state: ProjectState) {
        if checkContains(project, in: state) {
            edit(project, of: state)
        } else {
            add(project, in: state)
        }
    }
    
    private func checkContains(_ project: Project, in state: ProjectState) -> Bool {
        var isContains: Bool = false
        
        projectsGroup[state.index].forEach { savedProject in
            if savedProject.uuid == project.uuid {
                isContains = true
            }
        }
        
        return isContains
    }
    
    private func add(_ project: Project, in state: ProjectState) {
        projectsGroup[state.index].append(project)
        localDataManager.create(ProjectViewModel(project: project, state: state))
        remoteDataManager.create(ProjectViewModel(project: project, state: state))
        
        let projectHistory = ProjectHistory(Project: project, change: .add)
        projectHistories.insert(projectHistory, at: 0)
    }
    
    private func edit(_ project: Project, of state: ProjectState) {
        projectsGroup[state.index].enumerated().forEach { index, savedProject in
            guard savedProject.uuid == project.uuid else { return }
            
            projectsGroup[state.index][index] = project
            localDataManager.update(ProjectViewModel(project: project, state: state))
            remoteDataManager.update(ProjectViewModel(project: project, state: state))
            
            let projectHistory = ProjectHistory(Project: project, change: .update)
            projectHistories.insert(projectHistory, at: 0)
        }
    }
}

// MARK: - networkMonitor Delegate
extension MainViewModel: NetworkMonitorDelegate {
    func handlingNetworkChanges(isConnected: Bool) {
        if isConnected {
            self.networkIsConnected = true
            updateRemoteDataBase()
        } else {
            self.networkIsConnected = false
        }
    }
    
    func updateRemoteDataBase() {
        projectsGroup.enumerated().forEach { stateIndex, projects in
            let projectViewModels = projects.map { project in
                ProjectViewModel(project: project,
                                 state: ProjectState(rawValue: stateIndex) ?? .todo)
            }
            
            remoteDataManager.updateAfterNetworkConnection(projectViewModels: projectViewModels)
        }
    }
}

// MARK: - NameSpace
extension MainViewModel {
    
    private enum Default {
        
        static let title = ""
        static let detail = ""
        static let date = Date()
    }
}
