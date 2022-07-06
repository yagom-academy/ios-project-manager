//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박세리 on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @EnvironmentObject var viewModel: TodoViewModel
  let status: Todo.Status

  var body: some View {
    ZStack {
      Color(UIColor.systemGray5)
      List {
        ForEach(viewModel.read(by: status)) { list in
          TodoListCell(list)
        }
      }
      .padding(.horizontal, -24)
      .listStyle(.sidebar)
      .onAppear {
        UITableView.appearance().backgroundColor = .clear
      }
    }
    
  }
}
