//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct AppState: Equatable {
  var navigateState = NavigateState()
}

enum AppAction {
  case navigateAction(NavigateAction)
}

struct AppEnvironment {
  init() { }
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine([
  navigateReducer
    .pullback(
      state: \.navigateState,
      action: /AppAction.navigateAction,
      environment: { _ in NavigateEnvironment() }
    ),
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .navigateAction:
      return .none
    }
  }
])
