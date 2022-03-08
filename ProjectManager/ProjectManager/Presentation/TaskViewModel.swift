import Foundation

protocol TaskViewModelInput {
    func didChangeStatus()
}

protocol TaskViewModelOutput {
    var formattedTasks: [TaskEntity] { get set }
}

protocol TaskViewModelable: TaskViewModelInput, TaskViewModelOutput {}

final class TaskViewModel: TaskViewModelable {
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
