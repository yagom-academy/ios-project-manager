import Foundation
import RxSwift
import RxRelay

class ProjectViewModel {
    let memoryDataManager = Repository()
    var todoList = BehaviorSubject<[Work]>(value: [])
    var doingList = BehaviorSubject<[Work]>(value: [])
    var doneList = BehaviorSubject<[Work]>(value: [])
    
    init() {
        todoList.onNext(memoryDataManager.todoList)
        doingList.onNext(memoryDataManager.doingList)
        doneList.onNext(memoryDataManager.doneList)
    }
    
    func addWork(_ data: Work) {
        memoryDataManager.create(data)
        switch data.sort {
        case .todo:
            todoList.onNext(memoryDataManager.todoList)
        case .doing:
            doingList.onNext(memoryDataManager.doingList)
        case .done:
            doneList.onNext(memoryDataManager.doneList)
        }
    }

    func removeWork(_ data: Work) {

    }
    
    func updateWork(_ data: Work, title: String, body: String, date: Date, sort: Work.Sort) {

    }
}
