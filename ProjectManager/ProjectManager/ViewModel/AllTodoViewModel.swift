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
    
    var todoList = BehaviorSubject<[Project]>(value: [])
    var doingList = BehaviorSubject<[Project]>(value: [])
    var doneList = BehaviorSubject<[Project]>(value: [])
    
    var disposeBag = DisposeBag()
    
    // MARK: - initializer

    init() {
//        provider.todoList.subscribe(onNext: { [weak self] in
//            self?.todoList.onNext($0)
//        })
//        .disposed(by: disposeBag)
//
//        provider.doingList.subscribe(onNext: { [weak self] in
//            self?.doingList.onNext($0)
//        })
//        .disposed(by: disposeBag)
//
//        provider.doneList.subscribe(onNext: { [weak self] in
//            self?.doneList.onNext($0)
//        })
//        .disposed(by: disposeBag)
    }
    
    // MARK: - functions

    func transform(input: Input) -> Output {
        let todoList: BehaviorSubject<[Project]> = BehaviorSubject(value: [])
        let doingList: BehaviorSubject<[Project]> = BehaviorSubject(value: [])
        let doneList: BehaviorSubject<[Project]> = BehaviorSubject(value: [])
        provider.todoList
            .subscribe(onNext: { project in
                todoList.onNext(project)
            })
            .disposed(by: disposeBag)
        
        provider.doingList
            .subscribe(onNext: { project in
                doingList.onNext(project)
            })
            .disposed(by: disposeBag)
        
        provider.doneList
            .subscribe(onNext: { project in
                doneList.onNext(project)
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
}

struct Output {
    var todoList: Observable<[Project]>
    var doingList: Observable<[Project]>
    var doneList: Observable<[Project]>
}
