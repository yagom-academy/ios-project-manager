import Foundation

protocol TaskRepository {
    var dataSource: TaskDataSource { get }
    func fetchTasks() -> [TaskEntity]
}

class TaskDataRepository: TaskRepository {
    var dataSource: TaskDataSource
    
    init(dataSource: TaskDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchTasks() -> [TaskEntity] {
        return dataSource.fetchDatas()
    }
}
