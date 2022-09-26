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
        provider.allTodoData.subscribe(onNext: { [weak self] projects in
            let todoProjects = projects.filter { $0.status == .doing }
            self?.projectList.onNext(todoProjects)
        })
        .disposed(by: disposeBag)
    }
    
    func transform(_ input: DoingViewInput) -> DoingViewOutput {
        
        return DoingViewOutput(doingList: projectList)
    }
}

struct DoingViewInput {
}

struct DoingViewOutput {
    var doingList: Observable<[Project]>
}
