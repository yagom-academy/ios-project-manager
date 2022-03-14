import Foundation
import Combine

class TaskManager: TaskManagable {
    let taskListRepository = TaskListRepository()
    var taskList = [Task]()
    
    func taskList(at status: Task.ProgressStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
    
    func createTask(_ task: Task) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.taskList.append(task)
            let entityTask = self.convertEntityTask(from: task)
            self.taskListRepository.createEntityTask(entityTask: entityTask) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateTaskState(id: String, progressStatus: Task.ProgressStatus) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].progressStatus = progressStatus
            }
    }
    
    func updateTaskState(id: String, progressStatus: Task.ProgressStatus) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            let entityTaskStatus = progressStatus.rawValue
            self.taskListRepository.updateEntityTaskStatus(
                id: id,
                status: entityTaskStatus
            ) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].title = title
                taskList[$0].description = description
                taskList[$0].deadline = deadline.timeIntervalSince1970
            }
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.taskListRepository.updateEntityTask(
                id: id,
                title: title,
                description: description,
                deadline: deadline
            ) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteTask(_ id: String) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach { taskList.remove(at: $0) }
    }
    
    func deleteTask(_ id: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.taskListRepository.deleteEntityTask(id: id) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetch() -> AnyPublisher<[Task], Error> {
        Future<[Task], Error> { promise in
            self.taskListRepository.fetchEntityTask { entityTaskList in
                var taskList = [Task]()
                entityTaskList.forEach { entityTask in
                    let task = self.convertTask(from: entityTask)
                    taskList.append(task)
                }
                promise(.success(taskList))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func convertEntityTask(from task: Task) -> EntityTask {
        let id = task.id
        let title = task.title
        let description = task.description
        let deadline = task.deadline
        let progressStatus = task.progressStatus.rawValue
        let entityTask = EntityTask(
            id: id,
            title: title,
            description: description,
            deadline: deadline,
            progressStatus: progressStatus
        )
        
        return entityTask
    }
    
    private func convertTask(from entityTask: EntityTask) -> Task {
        let id = entityTask.id
        let title = entityTask.title
        let description = entityTask.description
        let deadline = entityTask.deadline
        let progressStatus = Task.ProgressStatus(rawValue: entityTask.progressStatus) ?? .todo
        let task = Task(
            id: id,
            title: title,
            description: description,
            deadline: deadline,
            progressStatus: progressStatus
        )
        
        return task
    }
}
