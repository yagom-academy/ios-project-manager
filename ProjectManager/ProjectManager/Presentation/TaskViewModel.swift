import Foundation

protocol TaskViewModelInput {
    func executeFetch()
}

protocol TaskViewModelOutput {
    var tasks: [TaskEntity] { get set }
}

final class TaskViewModel: TaskViewModelInput, TaskViewModelOutput {
    private var useCase: TaskUseCase
    var tasks: [TaskEntity] = []

    init(useCase: TaskUseCase) {
        self.useCase = useCase
    }
    
    func executeFetch() {
        tasks = useCase.execute()
    }
}
