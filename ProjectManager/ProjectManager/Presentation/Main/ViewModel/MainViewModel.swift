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

// MARK: - Sample Data

struct SampleData {
    static let one = ProjectContent(ProjectItem(title: "test", deadline: Date(), description: "tttttt555555555ttttttt"))
    static let two = ProjectContent(ProjectItem(title: "test2", deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, description: "tttttttt\nCCCCCCCC\n55\n433333"))
    static let three = ProjectContent(ProjectItem(title: "test3", deadline: Calendar.current.date(byAdding: .month, value: 1, to: Date())!, description: "tttttt\nCCCCCCCC\n5555333333\n4"))
    static let four = ProjectContent(ProjectItem(title: "test4", deadline: Date(), description: "ttttttttttttt\nCCCCCCCC\n5555333\n433333"))
    static let five = ProjectContent(ProjectItem(title: "test5", deadline: Calendar.current.date(byAdding: .month, value: -3, to: Date())!, description: "ttttttttttttt\nCCCCCCCC\n5555555\n433"))
    static let six = ProjectContent(ProjectItem(title: "test6", deadline: Calendar.current.date(byAdding: .year, value: 1, to: Date())!, description: "t\nCCCCCCCC\n555"))
}
