//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct ProjectManagerView: View {
  var body: some View {
    HStack(spacing: 10) {
      TodoListView(status: .todo)
        .environmentObject(TodoViewModel())
      
      TodoListView(status: .doing)
        .environmentObject(TodoViewModel())
      
      TodoListView(status: .done)
        .environmentObject(TodoViewModel())
    }
    .background(Color(UIColor.systemGray4))
  }
}
