//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxCocoa
import RxGesture

struct MainViewModel {
    private let projects: BehaviorRelay<[ProjectContent]> = {
        return ProjectUseCase().read()
    }()

    func deleteProject(_ content: ProjectContent) {
        ProjectUseCase().delete(projectContentID: content.id)
    }
    
    func readProject(_ id: UUID?) -> ProjectContent? {
        return ProjectUseCase().read(id: id)
    }
    
    func asTodoProjects() -> Driver<[ProjectContent]> {
        return projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func asDoingProjects() -> Driver<[ProjectContent]> {
        return projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func asDoneProjects() -> Driver<[ProjectContent]> {
        return projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func loadNetworkData() {
        ProjectUseCase().load()
    }
}
