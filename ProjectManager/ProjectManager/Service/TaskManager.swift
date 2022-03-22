import Foundation
import Combine

class TaskManager {
    let firebaseTaskListRepository = FirebaseTaskListRepository()
    let realmTaskListRepository = RealmTaskListRepository()
    var taskList = [Task]()
    
    func taskList(at status: TaskStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
}

// MARK: - Synchronization Method
extension TaskManager {
    func synchronizeFirebaseToRealm() -> AnyPublisher<Void, FirebaseError> {
        Future<Void, FirebaseError> { promise in
            self.firebaseTaskListRepository.fetchTask { result in
                switch result {
                case .success(let entityTaskList):
                    entityTaskList.forEach { entityTask in
                        let task = self.convertTask(from: entityTask)
                        let realmTask = self.convertRealmEntityTask(from: task)
                        self.realmTaskListRepository.mergeTask(realmTask)
                    }
                    promise(.success(()))
                case .failure:
                    promise(.failure(.fetchFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func synchronizeRealmToFirebase() throws {
        try realmTaskListRepository.fetchTask().forEach { realmTask in
            let task = convertTask(from: realmTask)
            let firebaseTask = convertFirebaseEntityTask(from: task)
            self.firebaseTaskListRepository.mergeTask(firebaseTask)
        }
    }
}

// MARK: - Firebase CRUD Method
extension TaskManager: FirebaseTaskManagable {
    func fetchFirebaseTaskList() -> AnyPublisher<[Task], FirebaseError> {
        Future<[Task], FirebaseError> { promise in
            self.firebaseTaskListRepository.fetchTask { result in
                var taskList = [Task]()
                switch result {
                case .success(let entityTaskList):
                    entityTaskList.forEach { entityTask in
                        let task = self.convertTask(from: entityTask)
                        taskList.append(task)
                    }
                    promise(.success(taskList))
                case .failure:
                    promise(.failure(.fetchFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func createFirebaseTask(_ task: Task) -> AnyPublisher<Bool, FirebaseError> {
        Future<Bool, FirebaseError> { promise in
            let entityTask = self.convertFirebaseEntityTask(from: task)
            self.firebaseTaskListRepository.createTask(entityTask: entityTask) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure:
                    promise(.failure(.createFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateFirebaseTask(
        id: String,
        title: String,
        description: String,
        deadline: Date
    ) -> AnyPublisher<Bool, FirebaseError> {
        Future<Bool, FirebaseError> { promise in
            self.firebaseTaskListRepository.updateTask(
                id: id,
                title: title,
                description: description,
                deadline: deadline
            ) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure:
                    promise(.failure(.updateFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateFirebaseTaskStatus(id: String, taskStatus: TaskStatus) -> AnyPublisher<Bool, FirebaseError> {
        Future<Bool, FirebaseError> { promise in
            let entityTaskStatus = taskStatus.rawValue
            self.firebaseTaskListRepository.updateTaskStatus(id: id, taskStatus: entityTaskStatus) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure:
                    promise(.failure(.updateFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteFirebaseTask(_ id: String) -> AnyPublisher<Bool, FirebaseError> {
        Future<Bool, FirebaseError> { promise in
            self.firebaseTaskListRepository.deleteTask(id: id) { result in
                switch result {
                case .success:
                    promise(.success(true))
                case .failure:
                    promise(.failure(.deleteFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Realm CRUD Method
extension TaskManager: RealmTaskManagable {
    func fetchRealmTaskList() throws {
        do {
            self.taskList = try realmTaskListRepository.fetchTask()
                .map { convertTask(from: $0) }
        } catch {
            throw RealmError.fetchFailed
        }
    }
    
    func createRealmTask(_ task: Task) throws {
        do {
            let realmTask = convertRealmEntityTask(from: task)
            try realmTaskListRepository.createTask(task: realmTask)
            try fetchRealmTaskList()
        } catch {
            throw RealmError.createFailed
        }
    }
    
    func updateRealmTask(id: String, title: String, description: String, deadline: Date) throws {
        do {
            try realmTaskListRepository.updateTask(id: id, title: title, description: description, deadline: deadline)
            try fetchRealmTaskList()
        } catch {
            throw RealmError.updateFailed
        }
    }
    
    func updateRealmTaskStatus(id: String, taskStatus: TaskStatus) throws {
        do {
            try realmTaskListRepository.updateTaskStatus(
                id: id,
                taskStatus: TaskStatus(rawValue: taskStatus.rawValue) ?? .todo
            )
            try fetchRealmTaskList()
        } catch {
            throw RealmError.updateFailed
        }
    }
    
    func deleteRealmTask(_ id: String) throws {
        do {
            try realmTaskListRepository.deleteTask(id: id)
            try fetchRealmTaskList()
        } catch {
            throw RealmError.deleteFailed
        }
    }
}

// MARK: - Convert Model Method
extension TaskManager {
    private func convertTask(from task: RealmEntityTask) -> Task {
        return Task(
            id: task.id,
            title: task.title,
            description: task.desc,
            deadline: task.deadline,
            progressStatus: TaskStatus(rawValue: task.progressStatus) ?? .todo
        )
    }
    
    private func convertRealmEntityTask(from task: Task) -> RealmEntityTask {
        let realmTask = RealmEntityTask()
        realmTask.id = task.id
        realmTask.title = task.title
        realmTask.desc = task.description
        realmTask.deadline = task.deadline
        realmTask.progressStatus = task.progressStatus.rawValue
        
        return realmTask
    }
    
    private func convertFirebaseEntityTask(from task: Task) -> FirebaseEntityTask {
        return FirebaseEntityTask(
            id: task.id,
            title: task.title,
            description: task.description,
            deadline: task.deadline,
            progressStatus: task.progressStatus.rawValue
        )
    }
    
    private func convertTask(from entityTask: FirebaseEntityTask) -> Task {
        return Task(
            id: entityTask.id,
            title: entityTask.title,
            description: entityTask.description,
            deadline: entityTask.deadline,
            progressStatus: TaskStatus(rawValue: entityTask.progressStatus) ?? .todo
        )
    }
}
