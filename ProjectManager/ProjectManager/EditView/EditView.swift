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
      // TODO: - 화면 세부 사항 구현하기
      VStack {
        Text("Project EditView")
      }
      .navigationTitle("TODO")
      .navigationBarTitleDisplayMode(.inline)
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
