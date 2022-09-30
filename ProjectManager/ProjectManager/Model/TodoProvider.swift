//
//  TodoProvider.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/21.
//

import RxSwift

final class TodoProvider {
    static let shared = TodoProvider()
    
    // MARK: - properties

    var allProjectList = BehaviorSubject<[Project]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - functions

    func saveData(project: Project) {
        guard var allProjects = try? allProjectList.value() else { return }
        allProjects.append(project)
        allProjectList.onNext(allProjects)
    }
    
    func updateData(project: Project) {
        guard var allProjects = try? allProjectList.value() else { return }
        guard let index = allProjects.firstIndex(where: {$0.uuid == project.uuid}) else { return }
        allProjects.remove(at: index)
        allProjects.insert(project, at: index)
        allProjectList.onNext(allProjects)
    }
    
    func deleteData(project: Project) {
        guard var allProjects = try? allProjectList.value() else { return }
        guard let index = allProjects.firstIndex(where: {$0.uuid == project.uuid}) else { return }
        allProjects.remove(at: index)
        allProjectList.onNext(allProjects)
    }
}
