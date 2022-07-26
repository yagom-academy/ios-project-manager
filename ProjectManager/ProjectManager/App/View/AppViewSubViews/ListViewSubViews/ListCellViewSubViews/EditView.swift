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
              viewModel.editButtonTapped()
            } label: {
              viewModel.nonEditable ? Text("Edit") : Text("Cancel")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.doneButtonTapped(viewModel.todo)
            }
          }
        }
    }
  }
}
