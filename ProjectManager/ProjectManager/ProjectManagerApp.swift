//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

@main
struct ProjectManagerApp: App {
  let store = Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment())
  
  var body: some Scene {
    WindowGroup {
      ProjectManagerAppView(store: store)
    }
  }
}
