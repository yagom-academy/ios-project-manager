//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

@main
struct ProjectManagerApp: App {
  let boardListStore = Store(
    initialState: BoardListStore.State(
      status: .todo,
      projects: Project.mock
    ),
    reducer: BoardListStore()
  )
  
  var body: some Scene {
    WindowGroup {
      BoardListView(boardListStore: boardListStore)
    }
  }
}
