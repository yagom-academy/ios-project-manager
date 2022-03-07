import Foundation
import RxSwift
import RxRelay

class ProjectViewModel {
    let repository = Repository()
    var todoList = BehaviorSubject<[Work]>(value: [])
    var doingList = BehaviorSubject<[Work]>(value: []) // notify , 데이터를 들고 있을 수 있다. 
    var doneList = BehaviorSubject<[Work]>(value: [])
    lazy var todoCount = todoList.map { $0.count }
    lazy var doingCount = doingList.map { $0.count }
    lazy var doneCount = doneList.map { $0.count }
    
    init() {
        todoList.onNext(repository.todoList)
        doingList.onNext(repository.doingList)
        doneList.onNext(repository.doneList)
    }
    
    func addWork(_ data: Work) {
        repository.create(data)
        switch data.sort {
        case .todo:
            todoList.onNext(repository.todoList)
        case .doing:
            doingList.onNext(repository.doingList)
        case .done:
            doneList.onNext(repository.doneList)
        }
    }

    func removeWork(_ data: Work) {

    }
    
    func updateWork(_ data: Work, title: String, body: String, date: Date, sort: Work.Sort) {

    }
}
