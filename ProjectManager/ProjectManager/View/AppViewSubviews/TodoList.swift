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
  
  init(status: Todo.Status, readList: @escaping (Todo.Status) -> [Todo]) {
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
            EditViewButton(todo: todo, isShowEditView: $isShowEditView)
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
  @Binding var isShowEditView: Bool

  var body: some View {
    Button {
      isShowEditView = true
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowEditView) {
      EditView(viewModel: EditViewModel(todoService: TodoService()), todo: todo, isShow: $isShowEditView)
    }
  }
}
