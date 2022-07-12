//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct AppView: View {
  @ObservedObject var viewModel: AppViewModel
  @State private var isShowDetailView = false
  
  init(viewModel: AppViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(todoService: viewModel.todoService, status: .todo) { status in
          viewModel.read(by: status)
        }
                
        TodoListView(todoService: viewModel.todoService, status: .doing) { status in
          viewModel.read(by: status)
        }
        TodoListView(todoService: viewModel.todoService, status: .done) { status in
          viewModel.read(by: status)
        }
      }
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button(action: {
          isShowDetailView.toggle()
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $isShowDetailView) {
        CreateView(viewModel: CreateViewModel(todoService: viewModel.todoService), isShow: $isShowDetailView)
      }
    }
    .navigationViewStyle(.stack)
  }
}
