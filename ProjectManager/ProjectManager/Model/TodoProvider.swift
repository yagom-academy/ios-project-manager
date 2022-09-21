//
//  TodoProvider.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/21.
//

import RxSwift

final class TodoProvider {
    
    // MARK: - properties

    let allTodoData = BehaviorSubject<[Project]>(value: [])
    
    let todoList = BehaviorSubject<[Project]>(value: [])
    let doingList = BehaviorSubject<[Project]>(value: [])
    let doneList = BehaviorSubject<[Project]>(value: [])
    
    private var testProjects: [Project]
    
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer

    init() {
        testProjects = Project.generateSampleData(count: 10,
                                                  maxBodyLine: 10,
                                                  startDate: "2022-09-01",
                                                  endData: "2022-09-30")
        
        allTodoData.onNext(testProjects)
        
        allTodoData.subscribe(onNext: { [weak self] projects in
            let todoProjects = projects.filter { $0.status == .todo }
            let doingProjects = projects.filter { $0.status == .doing }
            let doneProjects = projects.filter { $0.status == .done }
            
            self?.todoList.onNext(todoProjects)
            self?.doingList.onNext(doingProjects)
            self?.doneList.onNext(doneProjects)
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - functions

    func saveData(project: Project) {
        testProjects.append(project)
        allTodoData.onNext(testProjects)
    }
}
