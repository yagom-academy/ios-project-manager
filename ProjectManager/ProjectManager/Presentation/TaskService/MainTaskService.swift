//
//  MainTaskService.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//
import UIKit

class MainTaskService: TaskServiceProtocol {
    let taskUseCase: TaskUseCaseProtocol = TaskUseCase(repository: LocalTaskRepository())
    lazy var input = Input(
        viewDidLoad: viewDidLoad,
        addButtonDidTap: addButtonDidTap,
        doneButtonDidTap: doneButtonDidTap(viewModel:),
        cellDidTap: cellDidTap(index:state:),
        moveTask: moveTask(viewModel:currentState:changedState:),
        deleteButtonDidTap: deleteButtonDidTap(index:state:)
    )
    private let output: Output

    init(output: Output) {
        self.output = output
    }
    
    func viewDidLoad() {
        let viewModels = taskUseCase.fetch().map { TaskViewModel.init(task: $0) }
        
        output.showCells(viewModels)
    }
    
    func addButtonDidTap() {
        output.makeNewTask()
    }
    
    func cellDidTap(index: Int, state: TaskState) {
        let task = taskUseCase.fetch().filter { $0.state == state }[index]
        let viewModel = TaskViewModel.init(task: task)
        
        output.showAlert(viewModel)
    }
    
    func doneButtonDidTap(viewModel: TaskViewModel) {
        taskUseCase.insertContent(task: Task.init(viewModel: viewModel))
        output.createCell(viewModel)
    }
    
    func moveTask(viewModel: TaskViewModel, currentState: TaskState, changedState: [TaskState]) -> [UIAlertAction] {
        let firstAction = UIAlertAction(
            title: changedState[0].destination,
            style: .default
        ) { _ in
            let changedTask = Task.init(id: UUID(), title: viewModel.title, body: viewModel.body, date: viewModel.date.toDate(), state: changedState[0])
            let changedViewModel = TaskViewModel.init(task: changedTask)
            
            self.taskUseCase.update(task: changedTask)
            self.output.moveCell(viewModel, changedViewModel)
        }
        
        let secondAction = UIAlertAction(
            title: changedState[1].destination,
            style: .default
        ) { _ in
            let changedTask = Task.init(id: UUID(), title: viewModel.title, body: viewModel.body, date: viewModel.date.toDate(), state: changedState[1])
            let changedViewModel = TaskViewModel.init(task: changedTask)
            
            self.taskUseCase.update(task: changedTask)
            self.output.moveCell(viewModel, changedViewModel)
        }
        
        return [firstAction, secondAction]
    }
    
    func deleteButtonDidTap(
        index: Int,
        state: TaskState
    ) {
        let task = taskUseCase.fetch().filter { $0.state == state }[index]
        
        taskUseCase.delete(task: task)
        output.deleteCell(index, state)
    }
}

extension MainTaskService {
    struct Input {
        var viewDidLoad: () -> Void
        let addButtonDidTap: () -> Void
        let doneButtonDidTap: (TaskViewModel) -> Void
        let cellDidTap: (Int, TaskState) -> Void
        let moveTask: (TaskViewModel, TaskState, [TaskState]) -> [UIAlertAction]
        let deleteButtonDidTap: (Int, TaskState) -> Void
    }
    
    struct Output {
        let showCells: ([TaskViewModel]) -> Void
        let makeNewTask: () -> Void
        let createCell: (TaskViewModel) -> Void
        let showAlert: (TaskViewModel) -> Void
        let moveCell: (TaskViewModel, TaskViewModel) -> Void
        let deleteCell: (Int, TaskState) -> Void
    }
}
