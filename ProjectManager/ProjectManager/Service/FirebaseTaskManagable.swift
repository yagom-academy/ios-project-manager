import Foundation
import Combine

protocol FirebaseTaskManagable {
    var taskList: [Task] { get set }
    
    func fetchFirebaseTaskList() -> AnyPublisher<[Task], FirebaseError>
    func createFirebaseTask(_ task: Task) -> AnyPublisher<Bool, FirebaseError> 
    func updateFirebaseTask(
        id: String,
        title: String,
        description: String,
        deadline: Date
    ) -> AnyPublisher<Bool, FirebaseError>
    func updateFirebaseTaskStatus(id: String, taskStatus: Task.ProgressStatus) -> AnyPublisher<Bool, FirebaseError>
    func deleteFirebaseTask(_ id: String) -> AnyPublisher<Bool, FirebaseError>
}
