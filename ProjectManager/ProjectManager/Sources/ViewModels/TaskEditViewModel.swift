//
//  TaskEditViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/26.
//

import Foundation

struct TaskEditViewModel {

    var updated: ((IndexPath, Task) -> Void)?
    var created: ((Task) -> Void)?

    private(set) var task: Task?
    private(set) var indexPath: IndexPath?
    private var coreDataRepository: CoreDataRepository

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataRepository = CoreDataRepository(coreDataStack: coreDataStack)
    }

    mutating func setTask(_ task: Task?, indexPath: IndexPath?) {
        self.task = task
        self.indexPath = indexPath
    }

    mutating func update(title: String, dueDate: Date, body: String) {
        guard let task = task,
              let indexPath = indexPath else { return }

        let title: String? = (task.title == title) ? nil : title
        let dueDate: Date? = (task.dueDate == dueDate) ? nil : dueDate
        let body: String? = (task.body == body) ? nil : body

        let isChanged: Bool = title != nil || dueDate != nil || body != nil
        guard isChanged else { return }

        coreDataRepository.update(objectID: task.objectID, title: title, dueDate: dueDate, body: body)
        updated?(indexPath, task)
    }

    mutating func create(title: String, dueDate: Date, body: String) {
        guard let date = dueDate.date else { return }
        let body: String? = body.isEmpty ? nil : body

        if let task = try? coreDataRepository.create(title: title, body: body, dueDate: date, state: .todo) {
            self.task = task
            created?(task)
        }
    }
}
