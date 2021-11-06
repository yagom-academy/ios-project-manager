//
//  ProjectManagerView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import SwiftUI

struct ProjectManagerView: View {
    @State private var showModal = false
    @EnvironmentObject var todoListVM: TodoListViewModel
    
    let todoStatusList: [TodoStatus] = [.todo, .doing, .done]
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(todoStatusList) { todoStatus in
                    TodoListView(todoStatus: todoStatus, todoList: todoListVM.todos)
                }
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
                        self.showModal = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showModal, content: {
                        TodoModalView(showModal: $showModal)
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
            .environmentObject(TodoListViewModel())
    }
}
