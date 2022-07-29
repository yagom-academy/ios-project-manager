//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxSwift
import RxCocoa
import RxGesture

struct MainViewModel {
    private let projectUseCase: ProjectUseCase
    
    init(projectUseCase: ProjectUseCase) {
        self.projectUseCase = projectUseCase
    }
    
    private lazy var projects: BehaviorRelay<[ProjectEntity]> = {
        return projectUseCase.read()
    }()

    func deleteProject(_ content: ProjectEntity) {
        projectUseCase.delete(projectEntityID: content.id)
        deleteHistory(by: content)
    }
    
    func readProject(_ id: UUID?) -> ProjectEntity? {
        return projectUseCase.read(projectEntityID: id)
    }
    
    mutating func asTodoProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }
    
    mutating func asDoingProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }
    
    mutating func asDoneProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func loadNetworkData() -> Disposable {
        return projectUseCase.load()
    }
    
    private func deleteHistory(by content: ProjectEntity) {
        let historyEntity = HistoryEntity(
            editedType: .delete,
            title: content.title,
            date: Date().timeIntervalSince1970
        )
        
        projectUseCase.createHistory(historyEntity: historyEntity)
    }
}
