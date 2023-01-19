//
//  TodoCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct TodoState: Equatable {
  var projects: [Project] = []
  var detailState: DetailState?
}

enum TodoAction {
  // User Action
  case didDelete(IndexSet)
  case detailAction(DetailAction)
  
  // Inner Action
}

struct TodoEnvironment {
  init() { }
}

let TodoReducer = Reducer<TodoState, TodoAction, TodoEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.detailState,
      action: /TodoAction.detailAction,
      environment: { _ in DetailEnvironment()}
    ),
  Reducer<TodoState, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case let .didDelete(indexSet):
      indexSet.forEach { state.projects.remove(at: $0) }
      return .none
      
    case .detailAction:
      return .none
    }
  }
])
