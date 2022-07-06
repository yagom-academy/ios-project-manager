//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @EnvironmentObject var viewModel: TodoViewModel
  let status: Todo.Status

  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: status)
        .environmentObject(TodoViewModel())
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.read(by: status)) { list in
            TodoListCell(list)
          }
        }
        .padding(.horizontal, -24)
        .padding(.top, -30)
        .listStyle(.sidebar)
        .onAppear {
          UITableView.appearance().backgroundColor = .clear
        }
        
      }
    }
  }
}
