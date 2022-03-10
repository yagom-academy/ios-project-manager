import UIKit

protocol TaskListViewModelProtocol {
    var todoTasksObservable: MockObservable<[Task]>? { get }
    var doingTasksObservable: MockObservable<[Task]>? { get }
    var doneTasksObservable: MockObservable<[Task]>? { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func numberOfRowsInSection(for tableView: TaskTableView) -> Int
    func titleForHeaderInSection(for tableView: TaskTableView) -> String
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    func edit(task: Task, newProcessStatus: ProcessStatus)
}

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol?
    let todoTasksObservable: MockObservable<[Task]>?
    let doingTasksObservable: MockObservable<[Task]>?
    let doneTasksObservable: MockObservable<[Task]>?
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
        self.todoTasksObservable = MockObservable<[Task]>(taskRepository.todoTasks)
        self.doingTasksObservable = MockObservable<[Task]>(taskRepository.doingTasks)
        self.doneTasksObservable = MockObservable<[Task]>(taskRepository.doneTasks)
    }
    
    // MARK: - Methods
    func create(task: Task) {
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.value.append(task)
        case .doing:
            doingTasksObservable?.value.append(task)
        case .done:
            doneTasksObservable?.value.append(task)
        }
        
        taskRepository?.create(task: task)
    }
    
    func delete(task: Task) {
        switch task.processStatus {
        case .todo:
            if let index = findIndex(of: .todo, with: task.id) {
                todoTasksObservable?.value.remove(at: index)
            }
        case .doing:
            if let index = findIndex(of: .doing, with: task.id) {
                doingTasksObservable?.value.remove(at: index)
            }
        case .done:
            if let index = findIndex(of: .done, with: task.id) {
                doneTasksObservable?.value.remove(at: index)
            }
        }
        
        taskRepository?.delete(task: task)
    }
    
    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }
        
        guard let index = findIndex(of: task.processStatus, with: task.id) else {
            print(TaskManagerError.taskNotFound.description)
            return
        }
        
        let oldTaskId = task.id
        newTask.changeId(to: oldTaskId)
        
        // 이중 switch문 추상화 개선
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.value[index] = newTask
            moveTask(at: index, in: task.processStatus, to: newTask.processStatus)
        case .doing:
            doingTasksObservable?.value[index] = newTask
            moveTask(at: index, in: task.processStatus, to: newTask.processStatus)
        case .done:
            doneTasksObservable?.value[index] = newTask
            moveTask(at: index, in: task.processStatus, to: newTask.processStatus)
        }
        
        taskRepository?.update(task: task, to: newTask)
    }
    
    func moveTask(at index: Int, in taskObservableOfProcessStatus: ProcessStatus, to taskObservableOfNewProcessStatus: ProcessStatus) {
        guard taskObservableOfProcessStatus != taskObservableOfNewProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        var removedTask: Task?
        
        switch taskObservableOfProcessStatus {
        case .todo:
            removedTask = todoTasksObservable?.value.remove(at: index)
        case .doing:
            removedTask = doingTasksObservable?.value.remove(at: index)
        case .done:
            removedTask = doneTasksObservable?.value.remove(at: index)
        }
        
        switch taskObservableOfNewProcessStatus {
        case .todo:
            todoTasksObservable?.value.append(removedTask!)
        case .doing:
            doingTasksObservable?.value.append(removedTask!)
        case .done:
            doneTasksObservable?.value.append(removedTask!)
        }
    }
    
    func findIndex(of taskObservableOfProcessStatus: ProcessStatus, with id: UUID) -> Int? {
        switch taskObservableOfProcessStatus {
        case .todo:
            if let index = todoTasksObservable?.value.firstIndex(where: { $0.id == id }) {
                return index
            }
        case .doing:
            if let index = doingTasksObservable?.value.firstIndex(where: { $0.id == id }) {
                return index
            }
        case .done:
            if let index = doneTasksObservable?.value.firstIndex(where: { $0.id == id }) {
                return index
            }
        }
        
        return nil
    }
    
    // MARK: - TaskListView
    func numberOfRowsInSection(for tableView: TaskTableView) -> Int {
        switch tableView.processStatus {
        case .todo:
            return todoTasksObservable?.value.count ?? 0
        case .doing:
            return doingTasksObservable?.value.count ?? 0
        case .done:
            return doneTasksObservable?.value.count ?? 0
        default:
            print(TableViewError.invalidTableView)
            return 0
        }
    }
    
    func titleForHeaderInSection(for tableView: TaskTableView) -> String {
        switch tableView.processStatus {
        case .todo:
            guard let taskCount = todoTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.todo.description) \(taskCount)"
        case .doing:
            guard let taskCount = doingTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.doing.description) \(taskCount)"
        case .done:
            guard let taskCount = doneTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.done.description) \(taskCount)"
        case .none:
            print(TableViewError.invalidTableView)
            return ""
        }
    }
    
    // MARK: - TaskEditView
    // TODO: Popover에서 Title/Body/DueData Edit 기능 구현
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
    
    // TODO: Popover에서 ProcessStatus Edit 기능 구현
    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        let newTask = Task(title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
}
