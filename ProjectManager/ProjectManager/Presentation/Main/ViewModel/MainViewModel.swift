//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxSwift
import RxRelay

class MainViewModel {
    let toDoTableProjects = BehaviorRelay<[ProjectContent]>(value: [SampleData.one, SampleData.two, SampleData.six])
    let doingTableProjects = BehaviorRelay<[ProjectContent]>(value: [SampleData.three, SampleData.four])
    let doneTableProjects = BehaviorRelay<[ProjectContent]>(value: [SampleData.five])
}
