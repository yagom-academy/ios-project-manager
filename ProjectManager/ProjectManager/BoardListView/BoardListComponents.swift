//
//  BoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardListSectionHeader: View {
  let projectState: ProjectState
  let count: Int
  
  var body: some View {
    HStack {
      Text(projectState.description)
        .font(.largeTitle)
        .bold()
        .foregroundColor(.accentColor)
      
      Spacer()
      
      Text(count.description)
        .font(.title)
        .foregroundColor(.black)
        .bold()
        .padding()
        .background(
          Circle()
            .fill(.white)
        )
    }
    .padding()
    .background(Color.secondaryBackground)
    .cornerRadius(10)
  }
}

struct BoardListCellView: View {
  let project: Project
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        Text(project.title)
          .font(.title)
          .bold()
        
        Text(project.description)
          .font(.body)
        
        Text(project.date.convertedDateDescription)
          .font(.footnote)
      }
      
      Spacer()
    }
    .padding(10)
    .background(Color.secondaryBackground)
    .cornerRadius(10)
    .padding()

  }
}

struct BoardListView_Previews: PreviewProvider {
  static var previews: some View {
    BoardListCellView(
      project: Project(
        title: "Example",
        date: 99999999,
        description: "Example"
      )
    )
    .previewLayout(.sizeThatFits)
    
    BoardListSectionHeader(projectState: .todo, count: 20)
      .previewLayout(.sizeThatFits)
  }
}
