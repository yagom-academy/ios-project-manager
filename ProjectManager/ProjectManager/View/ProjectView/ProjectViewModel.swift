import Foundation
import RxSwift


final class ProjectViewModel {
    
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
        todoList.onNext(WorkCoreDataManager.shared.todoList)
        doingList.onNext(WorkCoreDataManager.shared.doingList)
        doneList.onNext(WorkCoreDataManager.shared.doneList)
    }
    
}
