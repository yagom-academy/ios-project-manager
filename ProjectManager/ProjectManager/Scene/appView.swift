//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI
import RealmSwift

struct AppView: View {
  @ObservedObject private var viewModel: AppViewModel
  
  init(viewModel: AppViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(viewModel: viewModel.todoListViewModel)
        TodoListView(viewModel: viewModel.doingListViewModel)
        TodoListView(viewModel: viewModel.doneListViewModel)
      }
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button(action: {
          viewModel.plusButtonTapped()
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $viewModel.isTappedPlusButton ) {
         CreateView(viewModel: viewModel.createViewModel)
      }
    }
    .navigationViewStyle(.stack)
  }
}
