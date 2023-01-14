//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectEditView: View {
  @State var canEdit: Bool = false
  
  @State var title: String = ""
  @State var selectedDate: Date = Date()
  @State var description: String = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        TextField("Title", text: $title)
          .textFieldStyle(.plain)
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!canEdit)
        
        DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
          Text("마감 기한")
            .font(.system(size: 20, weight: .semibold))
        }
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!canEdit)
        
        TextEditor(text: $description)
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!canEdit)
      }
      .padding(10)
      .navigationTitle("TODO")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            // TODO: - Edit Button 액션 구현
          } label: {
            Text("Edit")
          }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            // TODO: - Done Button 액션 구현
          } label: {
            Text("Done")
          }
        }
      }
      .background(Color.secondaryBackground)
    }
    .navigationViewStyle(.stack)
  }
}

struct ProjectEditView_Previews: PreviewProvider {
  static var previews: some View {
    
    ProjectEditView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
