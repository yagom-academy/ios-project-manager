//
//  TodoProvider.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/21.
//

import RxSwift

final class TodoProvider {
    static let shared = TodoProvider()
    
    // MARK: - properties

    let allTodoData = BehaviorSubject<[Project]>(value: [])
    
    private var testProjects: [Project]
    
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer

    init() {
        testProjects = Project.generateSampleData(count: 10,
                                                  maxBodyLine: 10,
                                                  startDate: "2022-09-01",
                                                  endData: "2022-09-30")
        
        allTodoData.onNext(testProjects)
    }
    
    // MARK: - functions

    func saveData(project: Project) {
        testProjects.append(project)
        allTodoData.onNext(testProjects)
    }
}
