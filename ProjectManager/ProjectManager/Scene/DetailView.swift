//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject var viewModel: TodoViewModel
  @ObservedObject var todo: Todo
  @State var nonEditable: Bool = true
  @Binding var isShow: Bool
  var method: choose
  
  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(.white)
            .shadow(color: .gray, radius: 3, x: 0, y: 1)
            .frame(height: 30)
          TextField("title", text: $todo.title)
            .padding(.leading)
            .disabled(nonEditable)
        }
        
        DatePicker("", selection: $todo.date)
          .datePickerStyle(.wheel)
          .labelsHidden()
          .disabled(nonEditable)
        TextEditor(text: $todo.content)
          .shadow(color: .gray, radius: 3, x: 0, y: 1)
          .disabled(nonEditable)
      }
      .padding()
      .navigationTitle("TODO")
      .font(.body)
      .navigationBarTitleDisplayMode(.inline)
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
          Button {
            isShow = false
            
            switch method {
            case .creat:
              viewModel.creat(todo: Todo(title: todo.title, content: todo.content, date: todo.date))
            case .update:
              viewModel.update(todo: todo)
            case .none:
              return
            }
            
          } label: {
            Text("Done")
          }
        }
      }
    }
  }
}


enum choose {
  case creat
  case update
  case none
}
