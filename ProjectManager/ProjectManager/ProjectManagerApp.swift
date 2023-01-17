//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

@main
struct ProjectManagerApp: App {
  let appStore = Store(
    initialState: AppStore.State(),
    reducer: AppStore()._printChanges()
  )
  
  var body: some Scene {
    WindowGroup {
      ProjectManagerAppView(store: appStore)
    }
  }
}
