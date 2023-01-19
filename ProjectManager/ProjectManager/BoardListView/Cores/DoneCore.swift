//
//  DoneCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DoneState: Equatable {
  var projects: [Project] = []
  var detailState: DetailState?
}

enum DoneAction {
  // User Action
  case didDelete(IndexSet)
  case movingToTodo(Project)
  case movingToDoing(Project)
  case detailAction(DetailAction)
  
  // Inner Action
}

struct DoneEnvironment {
  init() { }
}

let DoneReducer = Reducer<DoneState, DoneAction, DoneEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.detailState,
      action: /DoneAction.detailAction,
      environment: { _ in DetailEnvironment()}
    ),
  Reducer<DoneState, DoneAction, DoneEnvironment> { state, action, environment in
    switch action {
    case let .didDelete(indexSet):
      indexSet.forEach { state.projects.remove(at: $0) }
      return .none
      
    case let .movingToTodo(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let .movingToDoing(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case .detailAction:
      return .none
    }
  }
])

