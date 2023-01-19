//
//  DoginCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct DoingState: Equatable {
  var projects: [Project] = []
  var detailState: DetailState?
}

enum DoingAction {
  // User Action
  case didDelete(IndexSet)
  case movingToTodo(Project)
  case movingToDone(Project)
  case detailAction(DetailAction)
  
  // Inner Action
}

struct DoingEnvironment {
  init() { }
}

let DoingReducer = Reducer<DoingState, DoingAction, DoingEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.detailState,
      action: /DoingAction.detailAction,
      environment: { _ in DetailEnvironment()}
    ),
  Reducer<DoingState, DoingAction, DoingEnvironment> { state, action, environment in
    switch action {
    case let .didDelete(indexSet):
      indexSet.forEach { state.projects.remove(at: $0) }
      return .none
      
    case let .movingToTodo(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let .movingToDone(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case .detailAction:
      return .none
    
    }
  }
])

