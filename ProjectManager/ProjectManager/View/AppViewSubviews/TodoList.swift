//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.

import SwiftUI

struct TodoListView: View {
  @ObservedObject var viewModel: ListViewModel
  @ObservedObject var todoSerVice: TodoService
  private let status: Todo.Status
  private let updata: (Todo.Status, Todo) -> Void

  init(viewModel: ListViewModel,
       todoService: TodoService,
       status: Todo.Status,
       updata: @escaping (Todo.Status, Todo) -> Void
  ) {
    self.viewModel = viewModel
    self.todoSerVice = todoService
    self.status = status
    self.updata = updata
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: status, listCount: viewModel.read(by: status).count)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.read(by: status)) { todo in
            ListCellView(todo: todo, viewModel: viewModel, updata: updata)
              .listRowSeparator(.hidden)
          }
          .onDelete { index in
            viewModel.delete(set: index, status: status)
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

struct ListCellView: View {
  @State var isLongPressing = false
  @State var isShowEditView = false
//  @ObservedObject var todoService: TodoService
  @ObservedObject var viewModel: ListViewModel
  // 뷰 모델이 필요함. 셀 만을 위한 MV 가 필요한가?
  // 뷰 모델이
  let todo: Todo
  private let updata: (Todo.Status, Todo) -> Void
  
  init(todo: Todo, viewModel: ListViewModel, updata: @escaping (Todo.Status, Todo) -> Void) {
    self.todo = todo
    self.updata = updata
    self.viewModel = viewModel
  }
  
  var body: some View {
    TodoListCell(todo)
      .onTapGesture(perform: {
        isShowEditView = true
      })
      .onLongPressGesture(perform: {
        self.isLongPressing = true
      })
      .sheet(isPresented: $isShowEditView) {
        EditView(
          todo: Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: todo.status),
          isShow: $isShowEditView,
          viewModel: EditViewModel(todoService: viewModel.todoService))
      }
      .popover(isPresented: $isLongPressing) {
        TodoListPopOver(isShow: $isLongPressing, todo: todo, updata: updata)
      }
  }
}
