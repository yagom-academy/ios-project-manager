import Foundation

protocol TaskRepository {
    func create(task: TaskEntity)
    func readAll() -> [TaskEntity]
    func update(task: TaskEntity)
    func delete(task: TaskEntity)
}

class TaskDataRepository: TaskRepository {
    private var dataSource: TaskDataSource
    
    init(dataSource: TaskDataSource) {
        self.dataSource = dataSource
    }
    
    func create(task: TaskEntity) {
        dataSource.create(data: task)
    }
    
    func readAll() -> [TaskEntity] {
        return dataSource.readAll()
    }
    
    func update(task: TaskEntity) {
        dataSource.update(data: task)
    }
    
    func delete(task: TaskEntity) {
        dataSource.delete(data: task)
    }
}
