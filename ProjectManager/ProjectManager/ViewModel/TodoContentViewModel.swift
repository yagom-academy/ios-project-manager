//
//  TodoContentViewModel.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/26.
//

import SwiftUI

class TodoContentViewModel: ObservableObject {
    @Published var todo: Todo?
    @Published var title: String
    @Published var date: Date
    @Published var body: String
    @Published var buttonType: String
    @Published var showingSheet = false
    
    init(todo: Todo?, buttonType: String) {
        if let todo = todo, buttonType == "Edit" {
            self.todo = todo
            self.title = todo.title
            self.date = todo.date
            self.body = todo.body
            self.buttonType = "Edit"
        } else {
            self.todo = nil
            self.title = ""
            self.date = Date()
            self.body = ""
            self.buttonType = "Done"
        }
    }
    
    func manageTask(dataManger: DataManager, index: IndexSet?) {
        if buttonType == "Done", index == nil {
            dataManger.add(title: title, body: body, date: date, status: .todo)
        } else {
            guard let index = index?.first else { return }
            
            let id = dataManger.fetch()[index].id
            dataManger.update(id: id, title: title, body: body, date: date)
        }
        self.showingSheet.toggle()
    }
}
