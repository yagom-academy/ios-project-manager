//
//  CreateView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct CreateView: View {
  @State var todo = Todo(title: "", content: "")
  @Binding var isShow: Bool
  @ObservedObject var viewModel: CreateViewModel
  
  var body: some View {
    NavigationView {
      DetailView(todo: $todo)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Calcel") {
              isShow = false
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.creat(todo: todo)
              isShow = false
            }
          }
        }
    }
  }
}
