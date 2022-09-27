//
//  TodoContentViewModel.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/26.
//

import SwiftUI

class TodoContentViewModel: ObservableObject {
    @Binding var showingSheet: Bool
    @Published var todo: Todo?
    @Published var title: String
    @Published var date: Date
    @Published var body: String
    @Published var buttonType: String
    @Published var index: Int?
    
    init(todo: Todo?, buttonType: String, index: Int?, showingSheet: Binding<Bool>) {
        _showingSheet = showingSheet
        
        if let todo = todo {
            self.todo = todo
            self.title = todo.title
            self.date = todo.date
            self.body = todo.body
            self.buttonType = buttonType
            self.index = index
        } else {
            self.todo = nil
            self.title = ""
            self.date = Date()
            self.body = ""
            self.buttonType = buttonType
        }
    }
    
    func manageTask(dataManager: TodoDataManager) {
        if buttonType == "Done", index == nil {
            dataManager.add(title: title, body: body, date: date, status: .todo)
        } else {
            guard let index = index, let todo = todo else { return }
            
            let data = dataManager.fetch(by: todo.status)
            let id = data[index].id
            dataManager.update(id: id, title: title, body: body, date: date)
        }
        showingSheet.toggle()
    }
}
