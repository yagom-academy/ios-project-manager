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
    
    lazy var todoCountImage = todoWorks.map {
        UIImage(systemName: "\($0.count).circle.fill")
    }
    
    lazy var doingCountImage = doingWorks.map {
        UIImage(systemName: "\($0.count).circle.fill")
    }

    lazy var doneCountImage = doneWorks.map {
        UIImage(systemName: "\($0.count).circle.fill")
    }
    
    init() {
        todoWorks.accept(SampleData.todoWorks)
        doingWorks.accept(SampleData.doingWorks)
        doneWorks.accept(SampleData.doneWorks)
    }
}
