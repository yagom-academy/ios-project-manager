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
        ToolbarItem(placement: .navigationBarLeading) {
          Button(
            action: {
              viewModel.historyButtonTapped()
            },
            label: {
              Text("History")
            })
        }
        ToolbarItem(placement: .principal) {
          HStack {
            Text(viewModel.navigationTitle)
              .font(.title)
            Button {
              viewModel.syncRemoteDatabase()
            } label: {
              Image(systemName: "arrow.up.arrow.down.circle.fill")
            }
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
      .popover(isPresented: $viewModel.isShowHistoryView) {
        HistoryView(viewModel: viewModel.historyViewModel)
      }
    }
    .navigationViewStyle(.stack)
  }
}
