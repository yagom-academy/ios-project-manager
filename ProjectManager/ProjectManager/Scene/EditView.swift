//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct EditView: View {
  @State private var nonEditable: Bool = true
  @State var todo: Todo = Todo(title: "", content: "")
  @Binding var isShow: Bool
  @ObservedObject var viewModel: EditViewModel
  
  init(todo: Todo, isShow: Binding<Bool>, viewModel: EditViewModel) {
    self._isShow = isShow
    self.viewModel = viewModel
    self.todo = todo
  }
  
  var body: some View {
    NavigationView {
      DetailView(todo: $todo)
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
              viewModel.update(todo)
              isShow = false
            }
          }
        }
    }
  }
}
