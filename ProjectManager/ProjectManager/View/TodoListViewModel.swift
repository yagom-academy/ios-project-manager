//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todoRowItems = [TodoListItem]()
    @Published var doingRowItems = [TodoListItem]()
    @Published var doneRowItems = [TodoListItem]()
    @Published var todoCount = 0
    @Published var doingCount = 0
    @Published var doneCount = 0
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var isPresented: Bool = false

    func create() {
        let item = TodoListItem(title: title, description: description, date: date)
        todoRowItems.append(item)
    }
    
    func moveToDone() {
    }
    
    func moveToDoing() {
        
    }
    
    func addCount(count: inout Int) {
        return count += 1
    }
    
    func minusCount(count: inout Int) {
        return count -= 1
    }
    
    func remove(at offsets: IndexSet) {
        todoRowItems.remove(atOffsets: offsets)
        minusCount(count: &todoCount)
    }
    
    init() {
        print("ViewModelinit")
    }
}

