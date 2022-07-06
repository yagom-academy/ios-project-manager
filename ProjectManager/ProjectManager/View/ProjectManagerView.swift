//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct ProjectManagerView: View {
  @State private var showCreatView = false
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(status: .todo)
          .environmentObject(TodoViewModel())
        
        TodoListView(status: .doing)
          .environmentObject(TodoViewModel())
        
        TodoListView(status: .done)
          .environmentObject(TodoViewModel())
      }
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .font(.title)
      .toolbar {
        Button(action: {
          showCreatView.toggle()
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $showCreatView) {
        CreateView(title: "", date: Date(), content: "")
      }
    }
    .navigationViewStyle(.stack)
  }
}
