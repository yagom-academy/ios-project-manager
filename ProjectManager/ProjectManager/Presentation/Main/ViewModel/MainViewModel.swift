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

    lazy var todoProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }()

    lazy var doingProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }()

    lazy var doneProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }()

    func deleteProject(_ content: ProjectContent) {
        ProjectUseCase().delete(projectContentID: content.id)
    }
    
    func readProject(_ id: UUID?) -> ProjectContent? {
        return ProjectUseCase().read(id: id)
    }
    
    func findCell(by event: RxGestureRecognizer, in tableView: UITableView) -> ProjectCell? {
        let point = event.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: point),
              let cell = tableView.cellForRow(at: indexPath) as? ProjectCell else {
            return nil
        }
        
        return cell
    }
}
