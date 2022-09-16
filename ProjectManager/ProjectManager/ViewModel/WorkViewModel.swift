//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import RxSwift
import RxCocoa

class WorkViewModel {
    private let disposeBag = DisposeBag()
    
    let todoWorks = BehaviorRelay<[Work]>(value: [])
    let doingWorks = BehaviorRelay<[Work]>(value: [])
    let doneWorks = BehaviorRelay<[Work]>(value: [])
    
    init() {
        todoWorks.accept(SampleData.todoWorks)
        doingWorks.accept(SampleData.doingWorks)
        doneWorks.accept(SampleData.doneWorks)
    }
    
    func deleteWork(_ work: Work) {
        let works: BehaviorRelay<[Work]>
        
        switch work.state {
        case .todo:
            works = todoWorks
        case .doing:
            works = doingWorks
        case .done:
            works = doneWorks
        }
        
        works.map {
            $0.filter { $0.id != work.id }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .bind(to: works)
        .disposed(by: disposeBag)
    }
}
