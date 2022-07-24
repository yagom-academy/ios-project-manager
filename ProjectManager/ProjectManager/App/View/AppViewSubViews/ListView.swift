//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.

import SwiftUI

struct ListView: View {
  @ObservedObject var viewModel: ListViewModel
  
  init(viewModel: ListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(title: viewModel.status, listCount: viewModel.listCount)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.todoList) { todo in
            CellOperationView(viewModel: viewModel.makeCellViewModel(todo: todo))
              .listRowSeparator(.hidden)
          }
          .onDelete { index in
            viewModel.delete(set: index)
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
