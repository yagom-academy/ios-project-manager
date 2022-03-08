import Foundation

protocol TaskListViewProtocol: AnyObject {
    
}

protocol TaskListViewModelProtocol: AnyObject {
    // TODO: 데이터는 Repository 타입으로 구분할 예정
//    var todoTasks: [Task] { get }
//    var doingTasks: [Task] { get }
//    var doneTasks: [Task] { get }

    var todoTasksObservable: MockObservable<[Task]> { get }
    var doingTasksObservable: MockObservable<[Task]> { get }
    var doneTasksObservable: MockObservable<[Task]> { get }
    
    // TODO: Storage Protocol에서 CRUD 메서드를 정의하고, Repository(?)가 채택할 예정
    func create(task: Task, of processStatus: ProcessStatus)
    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
    func delete(task: Task, of processStatus: ProcessStatus)
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
    
//    func viewDidLoad()
    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String
}

final class TaskListViewModel: TaskListViewModelProtocol {
//final class TaskListViewModel {
//    var todoTasks: [Task] = []
//    var doingTasks: [Task] = []
//    var doneTasks: [Task] = []
    
//    weak var delegate: TaskListViewProtocol?  // MVVM에서는 View/ViewModel binding으로 대체
    let todoTasksObservable = MockObservable<[Task]>([])
    let doingTasksObservable = MockObservable<[Task]>([])
    let doneTasksObservable = MockObservable<[Task]>([])
    
    func create(task: Task, of processStatus: ProcessStatus) {
        switch processStatus {
        case .todo:
            todoTasksObservable.value.append(task)
//            todoTasks.append(task)
        case .doing:
            doingTasksObservable.value.append(task)
//            doingTasks.append(task)
        case .done:
            doneTasksObservable.value.append(task)
//            doneTasks.append(task)
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
}
