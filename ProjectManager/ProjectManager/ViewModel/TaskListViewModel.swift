import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var todoTaskList = [Task]()
    @Published var doingTaskList = [Task]()
    @Published var doneTaskList = [Task]()
    @Published var taskHistory = [TaskHistory]()
    @Published var errorAlert: ErrorModel?
    
    let taskListManager = TaskManager()
    let historyManager = TaskHistoryManager()

    var cancellables = Set<AnyCancellable>()
    
    init () {
        synchronizeFirebaseWithRealm()
    }
    
    private func reload() {
        self.todoTaskList = self.taskListManager.taskList(at: .todo)
        self.doingTaskList = self.taskListManager.taskList(at: .doing)
        self.doneTaskList = self.taskListManager.taskList(at: .done)
        self.taskHistory = self.historyManager.taskHistory
    }
    
    func synchronizeFirebaseWithRealm() {
        do {
            try taskListManager.synchronizeRealmToFirebase()
        } catch {
            print(error.localizedDescription)
        }
        taskListManager.synchronizeFirebaseToRealm()
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: {
                self.fetchRealm()
            }
            .store(in: &cancellables)
    }
    
    func fetchFirebase() {
        taskListManager.fetchFirebaseTaskList()
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { taskList in
                self.todoTaskList = taskList.filter { $0.progressStatus == .todo }
                self.doingTaskList = taskList.filter { $0.progressStatus == .doing }
                self.doneTaskList = taskList.filter { $0.progressStatus == .done }
            }
            .store(in: &cancellables)
    }
    
    func fetchRealm() {
        do {
            try taskListManager.fetchRealmTaskList()
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
        reload()
    }
    
    func createTask(_ task: Task) {
        do {
            try taskListManager.createRealmTask(task)
            historyManager.appendHistory(taskHandleType: .create(title: task.title))
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
        taskListManager.createFirebaseTask(task)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        do {
            try  taskListManager.updateRealmTask(id: id, title: title, description: description, deadline: deadline)
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
        taskListManager.updateFirebaseTask(id: id, title: title, description: description, deadline: deadline)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    func updateStatus(id: String, title: String, prevStatus: TaskStatus, nextStatus: TaskStatus) {
        do {
            try taskListManager.updateRealmTaskStatus(id: id, taskStatus: nextStatus)
            historyManager.appendHistory(
                taskHandleType: .move(
                    title: title,
                    prevStatus: prevStatus,
                    nextStatus: nextStatus
                )
            )
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
        taskListManager.updateFirebaseTaskStatus(id: id, taskStatus: nextStatus)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    func deleteTask(id: String, title: String, taskStatus: TaskStatus) {
        do {
            try  taskListManager.deleteRealmTask(id)
            historyManager.appendHistory(taskHandleType: .delete(title: title, status: taskStatus))
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
        taskListManager.deleteFirebaseTask(id)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    func changeableStatusList(from status: TaskStatus) -> [TaskStatus] {
        return TaskStatus.allCases.filter { $0 != status }
    }
}
