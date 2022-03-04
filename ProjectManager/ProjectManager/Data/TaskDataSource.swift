import Foundation

struct TaskDataSource {
    var tasks = [TaskEntity]()
    
    func fetchDatas() -> [TaskEntity] {
        return tasks
    }
}
