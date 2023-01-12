//
//  MainView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI

struct MainView: View {
  var body: some View {
    NavigationView {
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
              NavigationLink("\(number)") {
                Text("\(number)")
              }
              
            }
          }
        }
      }
      .navigationBarHidden(true)
    }
    .navigationViewStyle(.stack)
  }
}


struct MainView_PreView: PreviewProvider {
  static var previews: some View {
    if #available(iOS 15.0, *) {
      MainView()
        .previewLayout(.sizeThatFits)
        .previewInterfaceOrientation(.landscapeLeft)
    } else {
      MainView()
        .previewLayout(.sizeThatFits)
    }
  }
}
