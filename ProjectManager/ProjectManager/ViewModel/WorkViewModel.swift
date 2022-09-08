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
    
    var todoWorks = BehaviorRelay<[Work]>(value: [])
    var doingWorks = BehaviorRelay<[Work]>(value: [])
    var doneWorks = BehaviorRelay<[Work]>(value: [])
    
    init() {
        todoWorks.accept(SampleData.todoWorks)
        doingWorks.accept(SampleData.doingWorks)
        doneWorks.accept(SampleData.doneWorks)
    }
}
