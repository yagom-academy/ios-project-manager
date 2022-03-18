import Foundation
import RxSwift


final class ProjectViewModel {
    
    let workMemoryManager = WorkMemoryManager()
    
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
    
}
