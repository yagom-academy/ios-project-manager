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
          trailingImage: Image.plusImage,
          trailingAction: {
            // TODO: - Trailing Action Add
          }
        )
        
        HStack(spacing: 20) {
          ForEach(ProjectState.allCases, id: \.self) { state in
            VStack(spacing: 0) {
              ListTitleView(title: state.description, count: 5)
                .background(Color.secondary)
              // TODO: - List View 생성하기
            }
          }
        }
      }
      .background(Color.white)
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
      
      MainView()
        .previewLayout(.sizeThatFits)
        .previewInterfaceOrientation(.landscapeLeft)
        .preferredColorScheme(.dark)
      
    } else {
      MainView()
        .previewLayout(.sizeThatFits)
    }
  }
}
