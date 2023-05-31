//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Combine

protocol TaskListViewModel: AnyObject {
    var taskList: [Task] { get set }
    var currentTaskSubject: PassthroughSubject<([Task], Bool), Never> { get }
    var taskWorkState: WorkState { get }
    var delegate: TaskListViewModelDelegate? { get set }
    
    func createTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(at index: Int)
    func task(at index: Int) -> Task?
    func setState(isUpdating: Bool)
}

extension TaskListViewModel {
    func createTask(_ task: Task) {
        taskList.append(task)
        delegate?.createTask(task)
    }
    
    func updateTask(_ task: Task) {
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
    
    func task(at index: Int) -> Task? {
        return taskList[safe: index]
    }
}
