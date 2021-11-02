//
//  ContentView.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var todoListViewModel: ToDoListViewModel
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(viewModel: todoListViewModel, type: .toDo)
                TodoListView(viewModel: todoListViewModel, type: .doing)
                TodoListView(viewModel: todoListViewModel, type: .done)
            }
            .background(Color.gray)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $isPresented) {
                        NewTodoView(isDone: $isPresented)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
