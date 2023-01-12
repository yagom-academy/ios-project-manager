//
//  MainView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct MainView: View {
  let projects: [Project] = Project.mock
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
        
        HStack(spacing: 15) {
          ForEach(ProjectState.allCases, id: \.self) { state in
            VStack(spacing: 0) {
              let selectedProject = projects.filter { $0.state == state }
              
              ListTitleView(title: state.description, count: selectedProject.count)
              
              ProjectListView(projects: selectedProject)
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
