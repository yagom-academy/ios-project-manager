//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct TodoListPopOver: View {
  
  var body: some View {
    VStack {
      Button("MOVE to DOING") {
      }
      .buttonStyle(GrayBasicButtonStyle())
      Button("MOVE to DONE") {
      }
      .buttonStyle(GrayBasicButtonStyle())
    }
    .padding()
  }
}

struct GrayBasicButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .font(.body)
      .background(Color(UIColor.systemGray2))
      .foregroundColor(.white)
      .clipShape(RoundedRectangle(cornerRadius: 4))
  }
}
