//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct AppView: View {
  @State private var isShowDetailView = false
  @ObservedObject var viewModel: AppViewModel
  
  init(viewModel: AppViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(todoService: viewModel.todoService,
                     viewModel: viewModel,
                     status: .todo,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) },
                     delete: { viewModel.delete(set: $0, status: $1) })
        
        TodoListView(todoService: viewModel.todoService,
                     viewModel: viewModel,
                     status: .doing,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) },
                     delete: { viewModel.delete(set: $0, status: $1) })
        
        TodoListView(todoService: viewModel.todoService,
                     viewModel: viewModel,
                     status: .done,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) },
                     delete: { viewModel.delete(set: $0, status: $1) })
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
        CreateView(isShow: $isShowDetailView, viewModel: CreateViewModel(todoService: viewModel.todoService))
      }
    }
    .navigationViewStyle(.stack)
  }
}
