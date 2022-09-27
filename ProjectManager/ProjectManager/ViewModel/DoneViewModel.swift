//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

final class DoneViewModel: ViewModelType {
    
    // MARK: - properties
    
    let provider = TodoProvider.shared
    
    var projectList = BehaviorSubject<[Project]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        let projects = provider.testProjects.filter { $0.status == .done }
        self.projectList.onNext(projects)
    }
    
    func transform(_ input: DoneViewInput) -> DoneViewOutput {
        input.updateAction
            .bind(onNext: { [weak self] project in
                self?.provider.updateData(project: project)
                self?.resetProjectList(status: .done)
            })
            .disposed(by: disposeBag)
        
        return DoneViewOutput(doneList: projectList)
    }
    
    func resetProjectList(status: Status) {
        let projects = provider.testProjects.filter { $0.status == status }
        projectList.onNext(projects)
    }
}

struct DoneViewInput {
    let updateAction: Observable<Project>
}

struct DoneViewOutput {
    var doneList: Observable<[Project]>
}
