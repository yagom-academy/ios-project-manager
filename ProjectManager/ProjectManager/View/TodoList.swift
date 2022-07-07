//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @ObservedObject var viewModel: TodoViewModel
  @State var isShowDetailView: Bool
  let status: Todo.Status

  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: status)
        .environmentObject(TodoViewModel())
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.read(by: status)) { todo in
            DetailViewButton(viewModel: viewModel, todo: todo, isShowDetailView: $isShowDetailView)
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

struct DetailViewButton: View {
  @ObservedObject var viewModel: TodoViewModel
  @ObservedObject var todo: Todo
  @Binding var isShowDetailView: Bool
//  @State private var nonEditable = true
  
  var body: some View {
    Button {
      isShowDetailView = true
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowDetailView) {
      DetailView(viewModel: viewModel, todo: todo, isShow: $isShowDetailView)
  }
}
}
