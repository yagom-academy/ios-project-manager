//
//  TaskFormCreateSheetViewModel.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import Foundation

final class TaskFormViewModel: ObservableObject {
    
    @Published var title: String
    @Published var date: Date
    @Published var description: String
    @Published var isEditingMode = false
    
    var isReadOnlyMode: Bool {
        !isEditingMode
    }

    convenience init(task: Task) {
        self.init(title: task.title, date: task.dueDate, description: task.description)
    }
    
    convenience init() {
        self.init(title: "", date: Date(), description: "")
    }
    
    init(title: String, date: Date, description: String) {
        self.title = title
        self.date = date
        self.description = description
    }
    
    func resetForm(task: Task) {
        title = task.title
        date = task.dueDate
        description = task.description
    }
    
    func changeEditingMode(with task: Task, handler: () -> Void) {
        if isEditingMode {
            resetForm(task: task)
            handler()
        }
        isEditingMode.toggle()
    }
    
}
