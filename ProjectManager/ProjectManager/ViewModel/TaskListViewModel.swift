import Foundation

protocol TaskListViewModelProtocol: AnyObject {
    // TODO: Task 데이터는 Repository 타입으로 분리
    var todoTasksObservable: MockObservable<[Task]> { get }
    var doingTasksObservable: MockObservable<[Task]> { get }
    var doneTasksObservable: MockObservable<[Task]> { get }
    
    // TODO: Storage Protocol에서 CRUD 메서드를 정의하여 분리 (Repository가 프로토콜을 채택)
    func create(task: Task, of processStatus: ProcessStatus)
    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
    func delete(task: Task, of processStatus: ProcessStatus)
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
    
//    func viewDidLoad()
    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String
}

final class TaskListViewModel: TaskListViewModelProtocol {
    let todoTasksObservable = MockObservable<[Task]>([])
    let doingTasksObservable = MockObservable<[Task]>([])
    let doneTasksObservable = MockObservable<[Task]>([])
    
    func create(task: Task, of processStatus: ProcessStatus) {
        switch processStatus {
        case .todo:
            todoTasksObservable.value.append(task)
        case .doing:
            doingTasksObservable.value.append(task)
        case .done:
            doneTasksObservable.value.append(task)
        }
    }
    
    func updateTask(of task: Task, title: String, body: String, dueDate: Date) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    func delete(task: Task, of processStatus: ProcessStatus) {
        let id = task.id
        
        switch processStatus {
        case .todo:
            todoTasksObservable.value.removeAll { $0.id == id }
        case .doing:
            doingTasksObservable.value.removeAll { $0.id == id }
        case .done:
            doneTasksObservable.value.removeAll { $0.id == id }
        }
    }
    
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
    
    // MARK: - TaskListView
    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int {
        switch processStatus {
        case .todo:
            return todoTasksObservable.value.count
        case .doing:
            return doingTasksObservable.value.count
        case .done:
            return doneTasksObservable.value.count
        }
    }
    
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String {
        switch processStatus {
        case .todo:
            return "\(ProcessStatus.todo.description) \(todoTasksObservable.value.count)"
        case .doing:
            return "\(ProcessStatus.doing.description) \(doingTasksObservable.value.count)"
        case .done:
            return "\(ProcessStatus.done.description) \(doneTasksObservable.value.count)"
        }
    }
    
    // MARK: - TaskDetailView
    
}
