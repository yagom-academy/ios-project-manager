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
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .todo)
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .doing)
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .done)
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
        DetailView(viewModel: self.viewModel, todo: Todo(title: "", content: ""), nonEditable: false, isShow: $isShowDetailView, method: .creat)
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct MyPreviewProvider_Previews: PreviewProvider {
  static var previews: some View {
    ProjectManagerView(viewModel: TodoViewModel())
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
