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
    
    func doneButtonTapped(task: Task) {
        var testTask = task
        testTask.title = title
        testTask.body = body
        testTask.date = date
        
        self.service.editTask(task: testTask)
    }
}
