//
//  ProjectTaskViewModel.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/14.
//


import RxCocoa
import RxSwift
import UIKit

class ProjectTaskViewModel {
    private let disposeBag = DisposeBag()
    
    let todoTasks = BehaviorRelay<[ProjectTask]>(value: [])
    let doingTasks = BehaviorRelay<[ProjectTask]>(value: [])
    let doneTasks = BehaviorRelay<[ProjectTask]>(value: [])
    
    lazy var todoCountImage = todoTasks.value.count
    lazy var doingCountImage = doingTasks.value.count
    lazy var doneCountImage = doneTasks.value.count
}
