import Foundation
import Combine

protocol FirebaseTaskManagable {
    var taskList: [Task] { get set }
    
    func fetchFirebaseTaskList() -> AnyPublisher<[Task], Error>
    func createFirebaseTask(_ task: Task) -> AnyPublisher<Void, Error>
    func updateFirebaseTask(id: String, title: String, description: String, deadline: Date) -> AnyPublisher<Void, Error>
    func updateFirebaseTaskState(id: String, progressStatus: Task.ProgressStatus) -> AnyPublisher<Void, Error>
    func deleteFirebaseTask(_ id: String) -> AnyPublisher<Void, Error>
}
