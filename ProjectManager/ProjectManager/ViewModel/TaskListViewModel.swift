import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var todoTaskList = [Task]()
    @Published var doingTaskList = [Task]()
    @Published var doneTaskList = [Task]()
    
    let manager = TaskManager()

    var cancellables = Set<AnyCancellable>()
    
    init () {
        synchronizeFirebaseWithRealm()
    }
    
    private func reload() {
        self.todoTaskList = self.manager.taskList(at: .todo)
        self.doingTaskList = self.manager.taskList(at: .doing)
        self.doneTaskList = self.manager.taskList(at: .done)
    }
    
    func synchronizeFirebaseWithRealm() {
        manager.synchronizeRealmToFirebase()
        manager.synchronizeFirebaseToRealm()
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
        manager.fetchFirebaseTaskList()
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
        manager.fetchRealmTaskList()
        reload()
    }
    
    func createTask(_ task: Task) {
        manager.createRealmTask(task)
        manager.createFirebaseTask(task)
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
    
    func updateState(id: String, progressStatus: Task.ProgressStatus) {
        manager.updateRealmTaskState(id: id, progressStatus: progressStatus)
        manager.updateFirebaseTaskState(id: id, progressStatus: progressStatus)
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
        manager.updateRealmTask(id: id, title: title, description: description, deadline: deadline)
        manager.updateFirebaseTask(id: id, title: title, description: description, deadline: deadline)
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
    
    func deleteTask(_ id: String) {
        manager.deleteRealmTask(id)
        manager.deleteFirebaseTask(id)
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
    
    func changeableStatusList(from status: Task.ProgressStatus) -> [Task.ProgressStatus] {
        return Task.ProgressStatus.allCases.filter { $0 != status }
    }
}
