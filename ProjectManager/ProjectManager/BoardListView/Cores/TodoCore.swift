//
//  TodoCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct TodoState: Equatable {
  var projects: [Project] = []
  
  var isPresent: Bool = false
  var selectedState: DetailState?
}

enum TodoAction {
  // User Action
  case didDelete(IndexSet)
  case tapItem(Bool, Project?)
  case movingToDoing(Project)
  case movingToDone(Project)
  
  case detailAction(DetailAction)
  
  // Inner Action
  case _ChangePresentState(Bool)
  case _setSelectedState(Project?)
}

struct TodoEnvironment {
  init() { }
}

let todoReducer = Reducer<TodoState, TodoAction, TodoEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.selectedState,
      action: /TodoAction.detailAction,
      environment: { _ in DetailEnvironment()}
    ),
  Reducer<TodoState, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case let .didDelete(indexSet):
      indexSet.forEach { state.projects.remove(at: $0) }
      return .none
      
    case let .movingToDoing(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let .movingToDone(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let .tapItem(isPresent, project):
      return Effect.concatenate([
        Effect(value: ._ChangePresentState(isPresent)),
        Effect(value: ._setSelectedState(project))
      ])
      
    case let ._ChangePresentState(isPresent):
      if state.isPresent == isPresent {
        return .none
      } else {
        state.isPresent = isPresent
        return .none
      }
      
    case let ._setSelectedState(project):
      guard let project = project else { return .none }
      state.selectedState = DetailState(
        title: project.title,
        description: project.description,
        deadLineDate: project.date.convertedDate
      )
      
      return .none
      
    case .detailAction:
      return .none
    }
  }
])
