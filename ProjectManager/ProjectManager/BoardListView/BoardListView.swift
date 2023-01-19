//
//  BoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardListView: View {
  let store: Store<ProjectListState, ProjectListAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        
        Section(viewStore.projects.count.description) {
          ForEach(viewStore.projects, id: \.id) { project in
            BoardListCellView(project: project)
              .listRowSeparator(.hidden)
          }
        }
      }
      .listSectionSeparator(.hidden)
      .listStyle(.plain)
    }
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
  static let store = Store(
    initialState: ProjectListState(),
    reducer: projectListReducer,
    environment: ProjectListEnvironment()
  )
  static var previews: some View {
    BoardListView(store: store)
    
    BoardListCellView(
      project: Project(
        title: "Example",
        date: 99999999,
        description: "Example"
      )
    )
  }
}
