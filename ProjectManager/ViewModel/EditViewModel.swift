//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class EditViewModel: ViewModelType {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var date: Date = Date()
    
    func editTask(task: Task) {
        guard let item = self.service.tasks.filter ({ $0 == task }).first else {
            return
        }
        
        guard let index = service.tasks.firstIndex(of: item) else {
            return
        }
        
        service.tasks[index].title = service.tasks[index].title
        service.tasks[index].body = service.tasks[index].body
        service.tasks[index].date = service.tasks[index].date
    }
}
