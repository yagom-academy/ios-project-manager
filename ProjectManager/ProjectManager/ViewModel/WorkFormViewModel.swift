import Foundation
import RxSwift


final class WorkFormViewModel {
    
    private let workMemoryManager: WorkMemoryManager?
    
    private let todoList: BehaviorSubject<[Work]>?
    private let doingList: BehaviorSubject<[Work]>?
    private let doneList: BehaviorSubject<[Work]>?
    
    init(
        workMemoryManager: WorkMemoryManager,
        todoList: BehaviorSubject<[Work]>,
        doingList: BehaviorSubject<[Work]>,
        doneList: BehaviorSubject<[Work]>
    ) {
        self.workMemoryManager = workMemoryManager
        self.todoList = todoList
        self.doingList = doingList
        self.doneList = doneList
    }
    
    func addWork(_ data: Work) {
        guard let workMemoryManager = workMemoryManager else {
            return
        }
        
        workMemoryManager.create(data)
        
        switch data.category {
        case .todo:
            todoList?.onNext(workMemoryManager.todoList)
        case .doing:
            doingList?.onNext(workMemoryManager.doingList)
        case .done:
            doneList?.onNext(workMemoryManager.doneList)
        }
    }
    
    func updateWork(_ data: Work, title: String?, body: String?, date: Date) {
        guard let workMemoryManager = workMemoryManager else {
            return
        }
        
        workMemoryManager.update(data, title: title, body: body, date: date, category: data.category)
        
        switch data.category {
        case .todo:
            todoList?.onNext(workMemoryManager.todoList)
        case .doing:
            doingList?.onNext(workMemoryManager.doingList)
        case .done:
            doneList?.onNext(workMemoryManager.doneList)
        }
    }
    
}
