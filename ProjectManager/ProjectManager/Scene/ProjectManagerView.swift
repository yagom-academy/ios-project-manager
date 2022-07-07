//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct ProjectManagerView: View {
  @ObservedObject var viewModel: TodoViewModel
  @State private var isShowDetailView = false
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(viewModel: viewModel, status: .todo)
          
        TodoListView(viewModel: viewModel, status: .doing)
        
        TodoListView(viewModel: viewModel, status: .done)
      }
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .font(.title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button(action: {
          isShowDetailView.toggle()
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $isShowDetailView) {
        DetailView(viewModel: self.viewModel, isShow: $isShowDetailView)
      }
    }
    .navigationViewStyle(.stack)
  }
}
