import Foundation
import RxSwift

class ProjectViewModel {
    var workList = BehaviorSubject<[Work]>(value: [])
    var todoList = BehaviorSubject<[Work]>(value: [])
    var doingList = BehaviorSubject<[Work]>(value: [])
    var doneList = BehaviorSubject<[Work]>(value: [])
    
    init() {
        // Dummy Data
        let works: [Work] = [
            Work(title: "a", body: "a", date: Date()),
            Work(title: "abdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasf",
                 body: """
                       asdfasdf
                       asdfasdf
                       asdfasdfasdf
                       asdfasdfasdf
                       sadfasdfasdf
                       asdf
                       asdf
                       asdf
                       asdfasdfasdf
                       asddfa
                       """,
                 date: Date()),
            Work(title: "b", body: "c", date: Date(), sort: .doing),
            Work(title: "bbbbb", body: "xxxxx", date: Date(), sort: .done)
        ]
        
        let todo = works.filter { $0.sort == .todo }
        let doing = works.filter { $0.sort == .doing }
        let done = works.filter { $0.sort == .done }
        
        workList.onNext(works)
        todoList.onNext(todo)
        doingList.onNext(doing)
        doneList.onNext(done)
    }
    
    func create(_ data: Work) {
        let newWork = BehaviorSubject.just([data])
        
        _ = BehaviorSubject.merge(workList, newWork)
            .subscribe(onNext: {
                self.workList.onNext($0)
            })
    }

    func delete(_ data: Work) {
        _ = workList
            .map { works in
                works.filter { work in
                    data.id != work.id
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.workList.onNext($0)
            })
    }
    
    func update(_ data: Work, title: String, body: String, date: Date, sort: Work.Sort) {
        _ = workList
            .map({ works in
                works.map { work -> Work in
                    if work.id == data.id {
                        return Work(title: title, body: body, date: date, sort: sort)
                    } else {
                        return Work(title: work.title, body: work.body, date: work.date, sort: work.sort)
                    }
                }
            })
            .take(1)
            .subscribe(onNext: {
                self.workList.onNext($0)
            })
    }
}
