//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct appView: View {
  @ObservedObject var viewModel: TodoViewModel
  @State private var isShowDetailView = false
  
  init(viewModel: TodoViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance

    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .todo)
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .doing)
        TodoListView(viewModel: viewModel, isShowDetailView: isShowDetailView, status: .done)
      }
      .ignoresSafeArea(.container, edges: .bottom)
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
    .edgesIgnoringSafeArea(.top)
    .navigationViewStyle(.stack)
  }
}

struct MyPreviewProvider_Previews: PreviewProvider {
  static var previews: some View {
    appView(viewModel: TodoViewModel())
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
