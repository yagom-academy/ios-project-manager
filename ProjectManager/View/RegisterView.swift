//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/14.
//

import SwiftUI

struct RegisterView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject private(set) var registerViewModel: RegisterViewModel
  
  var body: some View {
    NavigationView {
      SheetView(taskTitle: $registerViewModel.title,
                taskBody: $registerViewModel.body,
                taskDate: $registerViewModel.date)
        .onDisappear {
          registerViewModel.title = ""
          registerViewModel.date = Date()
          registerViewModel.body = ""
        }
        .navigationTitle(TaskType.todo.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.systemGray5)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }) {
              Text("Cancel")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              registerViewModel.doneButtonTapped()
              presentationMode.wrappedValue.dismiss()
            }) {
              Text("Done")
            }
          }
        }
    }
    .navigationViewStyle(.stack)
  }
}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView(registerViewModel: RegisterViewModel(withService: TaskManagementService()))
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
