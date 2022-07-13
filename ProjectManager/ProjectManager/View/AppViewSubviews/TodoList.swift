//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @State var isShowEditView: Bool = false
  @ObservedObject var todoService: TodoService
  private let status: Todo.Status
  private let updata: (Todo.Status, Todo) -> Void
  
  init(todoService: TodoService,
       status: Todo.Status,
       updata: @escaping  (Todo.Status, Todo) -> Void) {
    self.todoService = todoService
    self.status = status
    self.updata = updata
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: status, listCount: todoService.read(by: status).count)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(todoService.read(by: status)) { todo in
            EditViewButton(todo: todo, todoService: todoService, isShowEditView: $isShowEditView, updata: updata)
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
  @State var isLongPressing = false
  @Binding var isShowEditView: Bool
  @ObservedObject var todo: Todo
  @ObservedObject var todoService: TodoService
  private let updata: (Todo.Status, Todo) -> Void
  
  init(todo: Todo, todoService: TodoService, isShowEditView: Binding<Bool>, updata: @escaping (Todo.Status, Todo) -> Void) {
    self.todo = todo
    self.todoService = todoService
    self._isShowEditView = isShowEditView
    self.updata = updata
  }
  
  var body: some View {
    Button {
      if isLongPressing {
        isLongPressing = false
      }
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowEditView) {
      EditView(
        viewModel: EditViewModel(todoService: todoService),
        todo: Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: todo.status),
        isShow: $isShowEditView)
    }
    .popover(isPresented: $isLongPressing) {
        TodoListPopOver(isShow: $isLongPressing, todo: todo, updata: updata)
    }
    .simultaneousGesture(TapGesture().onEnded {
      isShowEditView = true
    })
    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded({ _ in
      print("long")
      self.isLongPressing = true
    }))
  }
}
