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
    let networkManager = NetworkCheckManager()
 
    var cancellables = Set<AnyCancellable>()
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        networkManager.startMonitoring { isConnected in
            if isConnected {
                self.synchronizeFirebaseWithRealm()
            } else {
                self.errorAlert = ErrorModel(message: "Network is Not Connected".localized())
            }
        }
    }
    
    private func synchronizeFirebaseWithRealm() {
        synchronizeRealmToFirebase()
        synchronizeFirebaseToRealm()
    }
    
    private func reload() {
        todoTaskList = taskListManager.taskList(at: .todo)
        doingTaskList = taskListManager.taskList(at: .doing)
        doneTaskList = taskListManager.taskList(at: .done)
        taskHistory = historyManager.taskHistory
    }
    
    func changeableStatusList(from status: TaskStatus) -> [TaskStatus] {
        return TaskStatus.allCases.filter { $0 != status }
    }
}

// MARK: - Method used by View
extension TaskListViewModel {
    func createTask(_ task: Task) {
        if networkManager.isConnected {
            createTaskOnFirebase(task)
        }
        createTaskOnRealm(task)
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        if networkManager.isConnected {
            updateTaskOnFirebase(id: id, title: title, description: description, deadline: deadline)
        }
        updateTaskOnRealm(id: id, title: title, description: description, deadline: deadline)
    }
    
    func updateTaskStatus(id: String, title: String, prevStatus: TaskStatus, nextStatus: TaskStatus) {
        if networkManager.isConnected {
            updateStatusOnFirebase(id: id, title: title, status: nextStatus)
        }
        updateStatusOnRealm(id: id, title: title, prevStatus: prevStatus, nextStatus: nextStatus)
    }
    
    func deleteTask(id: String, title: String, taskStatus: TaskStatus) {
        if networkManager.isConnected {
            deleteTaskOnFirebase(id: id)
        }
        deleteTaskOnRealm(id: id, title: title, taskStatus: taskStatus)
    }
}

extension TaskListViewModel {
    private func synchronizeRealmToFirebase() {
        do {
            try taskListManager.synchronizeRealmToFirebase()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func synchronizeFirebaseToRealm() {
        taskListManager.synchronizeFirebaseToRealm()
            .sink { complition in
                switch complition {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: {
                self.fetchRealm()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Firebase CRUD Method
extension TaskListViewModel {
    private func fetchFirebase() {
        taskListManager.fetchFirebaseTaskList()
            .sink { complition in
                switch complition {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
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
    
    private func createTaskOnFirebase(_ task: Task) {
        taskListManager.createFirebaseTask(task)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    private func updateTaskOnFirebase(id: String, title: String, description: String, deadline: Date) {
        taskListManager.updateFirebaseTask(id: id, title: title, description: description, deadline: deadline)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    private func updateStatusOnFirebase(id: String, title: String, status: TaskStatus) {
        taskListManager.updateFirebaseTaskStatus(id: id, taskStatus: status)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
    
    private func deleteTaskOnFirebase(id: String) {
        taskListManager.deleteFirebaseTask(id)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorAlert = ErrorModel(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.reload()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Realm CRUD Method
extension TaskListViewModel {
    private func fetchRealm() {
        do {
            try taskListManager.fetchRealmTaskList()
            reload()
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    private func createTaskOnRealm(_ task: Task) {
        do {
            try taskListManager.createRealmTask(task)
            historyManager.appendHistory(taskHandleType: .create(title: task.title))
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    private func updateTaskOnRealm(id: String, title: String, description: String, deadline: Date) {
        do {
            try  taskListManager.updateRealmTask(id: id, title: title, description: description, deadline: deadline)
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    private func updateStatusOnRealm(id: String, title: String, prevStatus: TaskStatus, nextStatus: TaskStatus) {
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
    }
    
    private func deleteTaskOnRealm(id: String, title: String, taskStatus: TaskStatus) {
        do {
            try  taskListManager.deleteRealmTask(id)
            historyManager.appendHistory(taskHandleType: .delete(title: title, status: taskStatus))
        } catch {
            errorAlert = ErrorModel(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
}
