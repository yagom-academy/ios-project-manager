//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct AppState: Equatable {
  var navigateState = NavigateState()
  var todoListState = ProjectListState()
}

enum AppAction {
  case navigateAction(NavigateAction)
  case todoListAction(ProjectListAction)
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
  projectListReducer
    .pullback(
      state: \.todoListState,
      action: /AppAction.todoListAction,
      environment: { _ in ProjectListEnvironment() }
    ),
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .navigateAction(.detailAction(.didDoneTap)):
      guard let project = state.navigateState.createdProject else { return .none }
      state.todoListState.projects.append(project)
      return .none
      
    case .navigateAction:
      return .none
      
    case .todoListAction:
      return .none
    }
  }
])
