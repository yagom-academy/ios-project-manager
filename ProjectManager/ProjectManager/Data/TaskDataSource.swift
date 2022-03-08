import Foundation

struct TaskDataSource {
    private var tasks = [TaskEntity]()
    
    mutating func create(data: TaskEntity) {
        tasks.append(data)
    }
    
    func readAll() -> [TaskEntity] {
        return tasks
    }
    
    mutating func update(data: TaskEntity) {
        guard let index = tasks.firstIndex(where: { $0.id == data.id }) else { return }
        tasks[index] = data
    }
    
    mutating func delete(data: TaskEntity) {
        guard let index = tasks.firstIndex(where: { $0.id == data.id }) else { return }
        tasks.remove(at: index)
    }
}

