import UIKit

final class DefaultTaskViewModel: TaskViewModel, TaskRepositoryDelegate {
    var observer: TaskViewModelObserver?
    var repository: TaskRepository
    var taskLists: [TaskList] = []

    init(repository: TaskRepository) {
        self.repository = repository
        self.repository.delegate = self
        loadTaskList()
    }
}
