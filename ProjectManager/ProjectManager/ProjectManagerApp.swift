//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

@main
struct ProjectManagerApp: App {
  let store = Store(
    initialState: NavigateState(),
    reducer: navigateReducer,
    environment: NavigateEnvironment()
  )
  
  var body: some Scene {
    WindowGroup {
      NavigationBarView(navigationStore: store)
    }
  }
}
