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
        let didTapPopoverButton: [Observable<(UITableViewCell, Project)?>]
        let didSwapeToTapDeleteButton: [Observable<Project>]
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
                self.projectList[state.index] = filteredData
                projectList[state.index].onNext(filteredData)
            }
        }).disposed(by: disposeBag)
        
        input.didTapProjectCell.enumerated()
            .forEach({ column, observable in
                observable
                    .subscribe(onNext: { row in
                        let project = self.projectList[column][row]
                        self.coordinator?.presentDetailViewController(project, useCase: self.useCase, mode: .read)
                    }).disposed(by: disposeBag)
            })
        
        input.didTapAddButton
            .subscribe(onNext: { _ in
                let newProject = Project(title: "", description: "", date: Date())
                self.coordinator?.presentDetailViewController(newProject, useCase: self.useCase, mode: .add)
            }).disposed(by: disposeBag)
        
        input.didTapPopoverButton.forEach {
            $0.subscribe(onNext: { data in
                data.flatMap { cell, project in
                    
                    self.coordinator?.showActionSheet(
                        sourceView: cell,
                        titles: project.status.excluded,
                        topHandler: { _ in
                            self.useCase.changedState(
                                project,
                                state: ProjectState(rawValue: project.status.excluded.0) ?? ProjectState.todo
                            )
                        },
                        bottomHandler: { _ in
                            self.useCase.changedState(
                                project,
                                state: ProjectState(rawValue: project.status.excluded.1) ?? ProjectState.todo
                            )
                        }
                    )
                }
            }).disposed(by: disposeBag)
        }
        
        input.didSwapeToTapDeleteButton
            .forEach({ observable in
                observable
                    .subscribe(onNext: { project in
                        self.useCase.delete(project)
                    })
                    .disposed(by: disposeBag)
            })

        return Output(projectList: projectList.map { $0.asObservable() })
    }
}
