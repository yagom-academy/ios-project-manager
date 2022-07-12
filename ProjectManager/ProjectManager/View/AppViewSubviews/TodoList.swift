//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @State var isShowEditView: Bool = false
  private let status: Todo.Status
  private let readList: (Todo.Status) -> [Todo]
  let todoService: TodoService
  
  init(todoService: TodoService, status: Todo.Status, readList: @escaping (Todo.Status) -> [Todo]) {
    self.todoService = todoService
    self.status = status
    self.readList = readList
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: status, listCount: readList(status).count)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(readList(status)) { todo in
            EditViewButton(todo: todo, todoService: todoService, isShowEditView: $isShowEditView)
              .listRowSeparator(.hidden)
          }
        }
        .padding(.horizontal, -24)
        .listStyle(.inset)
        .onAppear {
          UITableView.appearance().backgroundColor = .clear
        }
      }
    }
  }
}

struct EditViewButton: View {
  @ObservedObject var todo: Todo
  let todoService: TodoService
  @Binding var isShowEditView: Bool

  var body: some View {
    Button {
      isShowEditView = true
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowEditView) {
      EditView(
        viewModel: EditViewModel(todoService: todoService),
        todo: Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: todo.status),
        isShow: $isShowEditView)
    }
  }
}
