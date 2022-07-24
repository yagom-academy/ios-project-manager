//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct EditView: View {
  @ObservedObject var viewModel: EditViewModel
  
  var body: some View {
    NavigationView {
      DetailView(todo: $viewModel.todo)
        .disabled(viewModel.nonEditable)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              if viewModel.nonEditable == true {
                viewModel.nonEditable = false
              } else {
                viewModel.update(viewModel.todo)
                
              }
            } label: {
              viewModel.nonEditable ? Text("Edit") : Text("Calcel")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.update(viewModel.todo)
            }
          }
        }
    }
  }
}
