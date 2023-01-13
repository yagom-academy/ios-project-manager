//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

@main
struct ProjectManagerApp: App {
  let boardStore = Store(
    initialState: BoardReducer.State(),
    reducer: BoardReducer()
  )
  
  var body: some Scene {
    WindowGroup {
      BoardView(boardReducer: boardStore)
    }
  }
}
