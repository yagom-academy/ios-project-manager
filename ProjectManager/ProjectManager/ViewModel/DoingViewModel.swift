//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

final class DoingViewModel: ViewModelType {
    
    // MARK: - properties
    
    let provider = TodoProvider.shared
    
    var projectList = BehaviorSubject<[Project]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        resetProjectList(status: .doing)
    }
    
    func transform(_ input: DoingViewInput) -> DoingViewOutput {
        input.updateAction
            .bind(onNext: { [weak self] project in
                self?.provider.updateData(project: project)
                self?.resetProjectList(status: .doing)
            })
            .disposed(by: disposeBag)
        
        return DoingViewOutput(doingList: projectList)
    }
}

struct DoingViewInput {
    let updateAction: Observable<Project>
}

struct DoingViewOutput {
    var doingList: Observable<[Project]>
}
