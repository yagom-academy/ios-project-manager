//
//  RegisterViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class RegisterViewModel: ViewModelType {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var date: Date = Date()
    
    func appendTask() {
        self.service.tasks.append(Task(title: title, date: date, body: body, type: .todo))
    }
}
