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
  @ObservedObject var viewModel: AppViewModel
  private let status: Todo.Status
  private let updata: (Todo.Status, Todo) -> Void
  private let delete: (IndexSet, Todo.Status) -> Void
  
  init(todoService: TodoService,
       viewModel: AppViewModel,
       status: Todo.Status,
       updata: @escaping (Todo.Status, Todo) -> Void,
       delete: @escaping (IndexSet, Todo.Status) -> Void
  ) {
    self.todoService = todoService
    self.viewModel = viewModel
    self.status = status
    self.updata = updata
    self.delete = delete
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
          .onDelete { index in
            delete(index, status)
          }
        }
        .refreshable {
          
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
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowEditView) {
      EditView(
        isShow: $isShowEditView,
        viewModel: EditViewModel(todoService: todoService),
        todo: Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: todo.status))
    }
    .popover(isPresented: $isLongPressing) {
        TodoListPopOver(isShow: $isLongPressing, todo: todo, updata: updata)
    }
    .onTapGesture(perform: {
      isShowEditView = true
    })
    .onLongPressGesture(perform: {
      self.isLongPressing = true
    })
  }
}
