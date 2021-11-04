//
//  ProjectManagerView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import SwiftUI

struct ProjectManagerView: View {
    @State private var showPopover = false
    @ObservedObject private var todoListVM = TodoListViewModel()
    
    init() {
        todoListVM.load()
    }
    
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(todoStatus: .todo, todoList: todoListVM.todos)
                
                TodoListView(todoStatus: .doing, todoList: todoListVM.todos)
                
                TodoListView(todoStatus: .done, todoList: todoListVM.todos)
            }
            .background(Color.init(UIColor(red: 210/256,
                                           green: 210/256,
                                           blue: 210/256,
                                           alpha: 1)))
            .navigationBarTitle(Text("Project Manager"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showPopover = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showPopover, content: {
                        TodoModalView(showPopover: $showPopover)
                    })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ProjectManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectManagerView()
    }
}
