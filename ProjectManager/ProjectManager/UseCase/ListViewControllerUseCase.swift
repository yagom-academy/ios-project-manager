//
//  ListViewControllerUseCase.swift
//  ProjectManager
//
//  Created by Hyungmin Lee on 2023/10/08.
//

import Foundation

protocol ListViewControllerUseCaseType {
    func convertTaskDTOFromTask(task: Task) -> TaskDTO
    func convertTaskFromTaskDTO(taskDTO: TaskDTO) -> Task
    func convertAlertsTitle(taskStatus: TaskStatus) -> (String, String)
}

final class ListViewControllerUseCase: ListViewControllerUseCaseType {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy. MM. dd."
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    func convertTaskDTOFromTask(task: Task) -> TaskDTO {
        let deadline = dateFormatter.string(from: Date(timeIntervalSince1970: task.deadline))
        let isPassDeadline = isPassDeadline(deadline: task.deadline)
        
        return TaskDTO(id: task.id,
                       title: task.title,
                       description: task.description,
                       deadline: deadline,
                       isPassDeadline: isPassDeadline,
                       taskStatus: task.taskStatus)
    }
    
    func convertTaskFromTaskDTO(taskDTO: TaskDTO) -> Task {
        let deadline = dateFormatter.date(from: taskDTO.deadline)?.timeIntervalSince1970 ?? 0
        
        return Task(id: taskDTO.id,
                    title: taskDTO.title,
                    description: taskDTO.description,
                    deadline: deadline,
                    taskStatus: taskDTO.taskStatus)
    }
    
    func convertAlertsTitle(taskStatus: TaskStatus) -> (String, String) {
        switch taskStatus {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
    }
    
    private func isPassDeadline(deadline: Double) -> Bool {
        let currentDateString = dateFormatter.string(from: Date())
        let deadlineDateString = dateFormatter.string(from: Date(timeIntervalSince1970: deadline))
        let currentDate = dateFormatter.date(from: currentDateString) ?? Date()
        let deadlineDate = dateFormatter.date(from: deadlineDateString) ?? Date()
        
        return currentDate.timeIntervalSince1970 > deadlineDate.timeIntervalSince1970
    }
}
