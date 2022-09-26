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
        provider.allTodoData.subscribe(onNext: { [weak self] projects in
            let todoProjects = projects.filter { $0.status == .done }
            self?.projectList.onNext(todoProjects)
        })
        .disposed(by: disposeBag)
    }
    
    func transform(_ input: DoneViewInput) -> DoneViewOutput {
        
        return DoneViewOutput(doneList: projectList)
    }
}

struct DoneViewInput {
}

struct DoneViewOutput {
    var doneList: Observable<[Project]>
}
