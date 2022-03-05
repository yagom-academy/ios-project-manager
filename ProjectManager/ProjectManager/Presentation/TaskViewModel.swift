import Foundation

protocol TaskViewModelInput {
    func didChangeStatus()
}

protocol TaskViewModelOutput {
    var formattedTasks: [TaskEntity] { get set }
}

protocol TaskViewModel: TaskViewModelInput, TaskViewModelOutput {}

final class TasksViewModel: TaskViewModel {
    private var useCase: TaskUseCase
    var formattedTasks: [TaskEntity] = []

    init(useCase: TaskUseCase) {
        self.useCase = useCase
    }
    
    func didChangeStatus() {}
    
    func executeFetch() {
        formattedTasks = useCase.executeFetch()
    }
}
