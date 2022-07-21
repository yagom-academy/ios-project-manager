//
//  CreateView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct CreateView: View {
  @ObservedObject var viewModel: CreateViewModel
  
  var body: some View {
    NavigationView {
      DetailView(todo: $viewModel.todo)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Calcel") {
              viewModel.cancelButtonTapped()
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.doneButtonTapped()
            }
          }
        }
    }
  }
}
