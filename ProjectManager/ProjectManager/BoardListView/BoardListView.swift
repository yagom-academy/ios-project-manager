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
        ForEach(viewStore.projects, id: \.id) { project in
          Text(project.title)
        }
      }
    }
  }
}
