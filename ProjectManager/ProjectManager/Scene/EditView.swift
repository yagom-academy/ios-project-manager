//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct EditView: View {
  @ObservedObject var viewModel: EditViewModel
  @ObservedObject var todo = Todo(title: "", content: "")
  @Binding var isShow: Bool
  @State var nonEditable: Bool = true
  
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
              isShow = false
              viewModel.update(todo: todo)
            }
          }
        }
    }
  }
}
