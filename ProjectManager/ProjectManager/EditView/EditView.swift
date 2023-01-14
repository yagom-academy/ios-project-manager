//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectEditView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Project EditView")
      }
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
