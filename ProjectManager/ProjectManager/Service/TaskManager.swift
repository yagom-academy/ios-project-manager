import Foundation
import Combine

class TaskManager {
    let firebaseTaskListRepository = FirebaseTaskListRepository()
    let realmTaskListRepository = RealmTaskListRepository()
    var taskList = [Task]()
    
    func taskList(at status: Task.ProgressStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
}

// MARK: - Synchronization Method
extension TaskManager {
    func synchronizeFirebaseToRealm() -> AnyPublisher<Void, FirebaseError> {
        Future<Void, FirebaseError> { promise in
            self.firebaseTaskListRepository.fetchEntityTask { result in
                switch result {
                case .success(let entityTaskList):
                    entityTaskList.forEach { entityTask in
                        let task = self.convertTask(from: entityTask)
                        let realmTask = self.convertRealmEntityTask(from: task)
                        self.realmTaskListRepository.syncTask(realmTask)
                    }
                    promise(.success(()))
                case .failure:
                    promise(.failure(.fetchFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func synchronizeRealmToFirebase() {
        realmTaskListRepository.fetch().forEach { realmTask in
            let task = convertTask(from: realmTask)
            let firebaseTask = convertFirebaseEntityTask(from: task)
            self.firebaseTaskListRepository.syncTask(firebaseTask)
        }
    }
}

// MARK: - Firebase CRUD Method
extension TaskManager: FirebaseTaskManagable {
    func fetchFirebaseTaskList() -> AnyPublisher<[Task], FirebaseError> {
        Future<[Task], FirebaseError> { promise in
            self.firebaseTaskListRepository.fetchEntityTask { result in
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
            self.firebaseTaskListRepository.createEntityTask(entityTask: entityTask) { result in
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
            self.firebaseTaskListRepository.updateEntityTask(
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
    
    func updateFirebaseTaskState(id: String, progressStatus: Task.ProgressStatus) -> AnyPublisher<Bool, FirebaseError> {
        Future<Bool, FirebaseError> { promise in
            let entityTaskStatus = progressStatus.rawValue
            self.firebaseTaskListRepository.updateEntityTaskStatus(id: id, status: entityTaskStatus) { result in
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
            self.firebaseTaskListRepository.deleteEntityTask(id: id) { result in
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
    func fetchRealmTaskList() {
        self.taskList = realmTaskListRepository.fetch()
            .map { convertTask(from: $0) }
    }
    
    func createRealmTask(_ task: Task) {
        let realmTask = convertRealmEntityTask(from: task)
        realmTaskListRepository.createEntityTask(task: realmTask)
        fetchRealmTaskList()
    }
    
    func updateRealmTask(id: String, title: String, description: String, deadline: Date) {
        realmTaskListRepository.updateTask(id: id, title: title, description: description, deadline: deadline)
        fetchRealmTaskList()
    }
    
    func updateRealmTaskState(id: String, progressStatus: Task.ProgressStatus) {
        realmTaskListRepository.updateTaskState(
            id: id,
            progressStatus: RealmEntityTask.ProgressStatus(rawValue: progressStatus.rawValue) ?? .todo
        )
        fetchRealmTaskList()
    }
    
    func deleteRealmTask(_ id: String) {
        realmTaskListRepository.deleteTask(id: id)
        fetchRealmTaskList()
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
            progressStatus: Task.ProgressStatus(rawValue: task.progressStatus) ?? .todo
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
            progressStatus: Task.ProgressStatus(rawValue: entityTask.progressStatus) ?? .todo
        )
    }
}
