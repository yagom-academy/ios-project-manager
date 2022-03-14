import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var todoTaskList = [Task]()
    @Published var doingTaskList = [Task]()
    @Published var doneTaskList = [Task]()
    
    let manager = TaskManager()

    var cancellables = Set<AnyCancellable>()
    
    init () {
        fetch()
    }
    
    func reload() {
        self.todoTaskList = self.manager.taskList(at: .todo)
        self.doingTaskList = self.manager.taskList(at: .doing)
        self.doneTaskList = self.manager.taskList(at: .done)
    }
    
    func fetch() {
        manager.fetch()
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print(error)
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
    
    func createTask(_ task: Task) {
        manager.createTask(task)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.fetch()
            }
            .store(in: &cancellables)
    }
    
    func updateState(id: String, progressStatus: Task.ProgressStatus) {
        manager.updateTaskState(id: id, progressStatus: progressStatus)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.fetch()
            }
            .store(in: &cancellables)
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        manager.updateTask(id: id, title: title, description: description, deadline: deadline)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            } receiveValue: { _ in
                self.fetch()
            }
            .store(in: &cancellables)
    }
    
    func deleteTask(_ task: Task) {
        manager.deleteTask(task.id)
        reload()
    }
    
    func changeableStatusList(from status: Task.ProgressStatus) -> [Task.ProgressStatus] {
        return Task.ProgressStatus.allCases.filter { $0 != status }
    }
}
