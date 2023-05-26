//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//
import Foundation

protocol TaskListViewModel: AnyObject {
    var taskList: [Task] { get set }
    var taskWorkState: WorkState { get }
    var delegate: TaskListViewModelDelegate? { get set }
    
    func updateTask(task: Task)
    func deleteTask(at index: Int)
    func changeTaskWorkState(id: UUID, with: WorkState)
    func task(at index: Int) -> Task?
}

extension TaskListViewModel {
    func updateTask(task: Task) {
        guard let targetIndex = taskList.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
        taskList[targetIndex] = task
        delegate?.updateTask(task)
    }
    
    func deleteTask(at index: Int) {
        let task = taskList.remove(at: index)
        delegate?.deleteTask(id: task.id)
    }
    
    func changeTaskWorkState(id: UUID, with: WorkState) {
        
    }
    
    func task(at index: Int) -> Task? {
        return taskList[safe: index]
    }
}
