//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

class TaskViewModel: TaskViewModelProtocol {
    var taskUseCase = TaskUseCase()
    
    func insertContents(data: TaskModelDTO) {
        taskUseCase.insertContents(data: data)
    }
    
    func fetch() -> [TaskModelDTO] {
        return taskUseCase.fetch()
    }
    
    func update(data: TaskModelDTO) {
        taskUseCase.update(data: data)
    }
    
    func delete(data: TaskModelDTO) {
        taskUseCase.delete(data: data)
    }
    
    func changeState(data: TaskModelDTO, to state: ProjectState) {
        let newData = TaskModelDTO(id: data.id, title: data.title, body: data.body, date: data.date, state: state)
        
        delete(data: data)
        insertContents(data: newData)
    }
}
