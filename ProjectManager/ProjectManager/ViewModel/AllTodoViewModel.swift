//
//  AllTodoViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import RxSwift

final class AllTodoViewModel {
    
    // MARK: - properties
    
    private var provider = TodoProvider()
    
    let todoList = BehaviorSubject<[Project]>(value: [])
    let doingList = BehaviorSubject<[Project]>(value: [])
    let doneList = BehaviorSubject<[Project]>(value: [])
    
    let disposeBag = DisposeBag()
    
    // MARK: - functions

    func transform(input: Input) -> Output {
        provider.todoList
            .subscribe(onNext: { [weak self] project in
                self?.todoList.onNext(project)
            })
            .disposed(by: disposeBag)
        
        provider.doingList
            .subscribe(onNext: { [weak self] project in
                self?.doingList.onNext(project)
            })
            .disposed(by: disposeBag)
        
        provider.doneList
            .subscribe(onNext: { [weak self] project in
                self?.doneList.onNext(project)
            })
            .disposed(by: disposeBag)
        
        input.addButtonAction
            .subscribe(onNext: {
                self.provider.saveData(project: $0)
            })
            .disposed(by: disposeBag)
        return Output(todoList: todoList, doingList: doingList, doneList: doneList)
    }
}

struct Input {
    var addButtonAction: Observable<Project>
    var changeStatus: Observable<UIGestureRecognizer>?
}

struct Output {
    var todoList: Observable<[Project]>
    var doingList: Observable<[Project]>
    var doneList: Observable<[Project]>
}
