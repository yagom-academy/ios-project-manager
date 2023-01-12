//
//  MainView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI

struct MainView: View {
  var body: some View {
    VStack {
      NavigationTitleView(
        title: "Project Manager",
        trailingName: "plus",
        trailingAction: {
          // TODO: - Trailing Action Add
        }
      )
      
      HStack {
        ForEach(0..<3, id: \.self) { _ in
          List(1...100, id: \.self) { number in
            Text("\(number)")
          }
        }
      }
    }
    .navigationBarHidden(true)
  }
}
