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
      VStack(spacing: 0) {
        BoardListSectionHeader(
          projectState: .todo,
          count: viewStore.projects.count
        )
        .padding()
        
        Divider()
          .frame(height: 2)
          .background(Color.accentColor)
          .padding(.horizontal)
          .cornerRadius(10)
          
        
        List {
          ForEach(viewStore.projects, id: \.id) { project in
            BoardListCellView(project: project)
              .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
              .listRowSeparator(.hidden)
          }
        }
        .listStyle(.plain)
      }
    }
  }
}

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
