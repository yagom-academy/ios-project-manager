//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct EditView: View {
  @State var nonEditable: Bool = true
  @Binding var isShow: Bool
  @ObservedObject var viewModel: EditViewModel
  var todo = Todo(title: "", content: "")
  
  var body: some View {
    NavigationView {
      DetailView(todo: todo)
        .disabled(nonEditable)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              if nonEditable == true {
                nonEditable = false
              } else {
                isShow = false
              }
            } label: {
              nonEditable ? Text("Edit") : Text("Calcel")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.update(todo: todo)
              isShow = false
            }
          }
        }
    }
  }
}
