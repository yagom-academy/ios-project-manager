import Foundation
import RxSwift
import UIKit

final class ProjectListViewModel {
    private var allProjects: [Project] = []
    private(set) var projectList: [[Project]] = [[], [], []]
    private let useCase: ProjectListUseCase
    private let coordinator: MainCoordinator?
    
    init(useCase: ProjectListUseCase = DefaultProjectListUseCase(), coordinator: MainCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let didTapProjectCell: [Observable<Int>]
        let didTapAddButton: Observable<Void>
        let didTapCellLongPress: [Observable<(UITableViewCell, Project)?>]
        let didSwipeToTapDeleteButton: [Observable<Project>]
    }
    
    struct Output {
        let projectList: [Observable<[Project]>]
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let projectList = [
                BehaviorSubject<[Project]>(value: []),
                BehaviorSubject<[Project]>(value: []),
                BehaviorSubject<[Project]>(value: [])
        ]
        
        useCase.fetch().subscribe(onNext: { newProjects in
            self.allProjects = newProjects.sorted { $0.date < $1.date }
            ProjectState.allCases.forEach { state in
                let filteredData = self.allProjects.filter { $0.status == state }
                self.projectList[state.rawValue] = filteredData
                projectList[state.rawValue].onNext(filteredData)
            }
        }).disposed(by: disposeBag)
        
        input.didTapProjectCell.enumerated()
            .forEach({ column, observable in
                observable
                    .withUnretained(self)
                    .subscribe(onNext: { owner, row in
                        let project = owner.projectList[column][row]
                        owner.coordinator?.presentDetailViewController(project, useCase: owner.useCase, mode: .read)
                    }).disposed(by: disposeBag)
            })
        
        input.didTapAddButton
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let newProject = Project(title: "", description: "", date: Date())
                owner.coordinator?.presentDetailViewController(newProject, useCase: owner.useCase, mode: .add)
            }).disposed(by: disposeBag)
        
        input.didTapCellLongPress.forEach {
            $0.withUnretained(self).subscribe(onNext: { owner, data in
                data.flatMap { cell, project in
                    owner.coordinator?.showActionSheet(sourceView: cell, titles: project.status.excluded)
                        .subscribe(onNext: { state in
                            owner.useCase.changedState(project, state: state)
                        }).disposed(by: disposeBag)
                }
            }).disposed(by: disposeBag)
        }
        
        input.didSwipeToTapDeleteButton
            .forEach({ observable in
                observable
                    .withUnretained(self).subscribe(onNext: { owner, project in
                        owner.useCase.delete(project)
                    })
                    .disposed(by: disposeBag)
            })

        return Output(projectList: projectList.map { $0.asObservable() })
    }
}
