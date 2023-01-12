//
//  ProjectListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI

struct ProjectListView: View {
  var projects: [Project]
  
  var body: some View {
    List(projects, id: \.id) { project in
      ProjectListCellView(project: project)
    }
    .listStyle(.plain)
  }
}


struct ProjectListCellView: View {
  let project: Project
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(project.title)
        Text("\(Date().description)")
        Text(project.description)
      }
      
      Spacer()
    }
    .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
    .listRowSeparator(.hidden)
    .padding(10)
    .background(.thickMaterial)
    .cornerRadius(7)
  }
}
