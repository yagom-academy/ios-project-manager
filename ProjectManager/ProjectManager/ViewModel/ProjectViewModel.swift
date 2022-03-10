import Foundation
import RxSwift
import UIKit


final class ProjectViewModel {
    
    private let workMemoryManager = WorkMemoryManager()
    
    let todoList = BehaviorSubject<[Work]>(value: [])
    let doingList = BehaviorSubject<[Work]>(value: [])
    let doneList = BehaviorSubject<[Work]>(value: [])
    
    var todoCount: Observable<Int> {
        todoList.map { $0.count }
    }
    var doingCount: Observable<Int> {
        doingList.map { $0.count }
    }
    var doneCount: Observable<Int> {
        doneList.map { $0.count }
    }
    
    init() {
        todoList.onNext(workMemoryManager.todoList)
        doingList.onNext(workMemoryManager.doingList)
        doneList.onNext(workMemoryManager.doneList)
    }
    
    func addWork(_ data: Work) {
        workMemoryManager.create(data)
        
        switch data.category {
        case .todo:
            todoList.onNext(workMemoryManager.todoList)
        case .doing:
            doingList.onNext(workMemoryManager.doingList)
        case .done:
            doneList.onNext(workMemoryManager.doneList)
        }
    }

    func removeWork(_ data: Work) {
    }
    
    func updateWork(_ data: Work, title: String, body: String, date: Date, sort: Work.Category) {
    }
    
}
