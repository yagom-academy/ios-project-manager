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
        ListView(viewModel: viewModel.todoListViewModel)
        ListView(viewModel: viewModel.doingListViewModel)
        ListView(viewModel: viewModel.doneListViewModel)
      }
      .background(Color(UIColor.systemGray4))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          HStack {
            Text(viewModel.navigationTitle)
              .font(.title)
            Image(systemName: "circle.fill")
              .foregroundColor(viewModel.isConnectedNetwork ? .green : .red)
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            viewModel.plusButtonTapped()
          }, label: {
            Image(systemName: "plus")
          })
        }
      }
      .sheet(isPresented: $viewModel.isShowCreateView) {
        CreateView(viewModel: viewModel.createViewModel)
      }
    }
    .navigationViewStyle(.stack)
  }
}
