//
//  DoneCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DoneState: Equatable {
  var projects: [Project] = []
  
  var isPresent: Bool = false
  var selectedState: DetailState?
}

enum DoneAction {
  // User Action
  case didDelete(IndexSet)
  case tapItem(Bool, Project?)
  case movingToTodo(Project)
  case movingToDoing(Project)
  case detailAction(DetailAction)
  
  // Inner Action
  case _changePresentState(Bool)
  case _setSelectedState(Project?)
}

struct DoneEnvironment {
  init() { }
}

let doneReducer = Reducer<DoneState, DoneAction, DoneEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.selectedState,
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
      
    case let .tapItem(isPresent, project):
      return Effect.concatenate([
        Effect(value: ._changePresentState(isPresent)),
        Effect(value: ._setSelectedState(project))
      ])
    case let ._changePresentState(isPresent):
      guard state.isPresent != isPresent else { return .none }
      state.isPresent = isPresent
      return .none
      
    case let ._setSelectedState(project):
      guard let project = project else { return .none }
      state.selectedState = DetailState(
        title: project.title,
        description: project.description,
        deadLineDate: project.date.convertedDate
      )
      return .none
    }
  }
])

