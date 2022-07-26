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
    private let projects: BehaviorRelay<[ProjectEntity]> = {
        return ProjectUseCase().read()
    }()

    func deleteProject(_ content: ProjectEntity) {
        ProjectUseCase().delete(projectContentID: content.id)
        deleteHistory(by: content)
    }
    
    func readProject(_ id: UUID?) -> ProjectEntity? {
        return ProjectUseCase().read(id: id)
    }
    
    func asTodoProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func asDoingProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func asDoneProjects() -> Driver<[ProjectEntity]> {
        return projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func loadNetworkData() -> Disposable {
        return ProjectUseCase().load()
    }
    
    private func deleteHistory(by content: ProjectEntity) {
        let historyEntity = HistoryEntity(
            editedType: .delete,
            title: content.title,
            date: Date().timeIntervalSince1970
        )
        
        ProjectUseCase().createHistory(historyEntity: historyEntity)
    }
}
