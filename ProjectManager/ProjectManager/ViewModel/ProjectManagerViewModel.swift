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
        let addedWorkList = memoryDataManager.fetchAll()
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
//        _ = workList
//            .map { works in
//                works.filter { work in
//                    data.id != work.id
//                }
//            }
//            .take(1)
//            .subscribe(onNext: {
//                self.workList.onNext($0)
//            })
    }
    
    func updateWork(_ data: Work, title: String, body: String, date: Date, sort: Work.Sort) {
//        _ = workList
//            .map({ works in
//                works.map { work -> Work in
//                    if work.id == data.id {
//                        return Work(title: title, body: body, dueDate: date, sort: sort)
//                    } else {
//                        return Work(title: work.title, body: work.body, dueDate: work.dueDate, sort: work.sort)
//                    }
//                }
//            })
//            .take(1)
//            .subscribe(onNext: {
//                self.workList.onNext($0)
//            })
    }
}
