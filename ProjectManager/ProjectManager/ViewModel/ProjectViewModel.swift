//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/30.
//

import RxSwift

final class ProjectViewModel: ViewModelType {
    
    struct Input {
        let showTouchData: Int

    }

    struct Output {
        let projectList: Observable<Project>
    }
    
    let provider = TodoProvider.shared
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output? {
        let projectList = BehaviorSubject<[Project]>(value: [])
        resetProjectList(projectList: projectList)
        
        let project = projectList
            .map { $0[input.showTouchData] }
        
        return Output(projectList: project)
    }
    
    func resetProjectList(projectList: BehaviorSubject<[Project]>) {
        provider.allProjectList.bind(onNext: { projects in
            projectList.onNext(projects)
        })
        .disposed(by: disposeBag)
    }
}
