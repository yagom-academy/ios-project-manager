//
//  NavigationStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct SheetState: Equatable {
  var isPresent: Bool = false
  var title: String = "Project Manager"
  var detailState: DetailState?
  
  var createdProject: Project?
}

enum SheetAction {
  // User Action
  case didTapPresent(Bool)
  
  // Inner Action
  case _setIsPresent
  case _setIsNotPresent
  case _createDetailState
  case _deleteDetailState
  
  // Child Action
  case detailAction(DetailAction)
}

struct SheetEnvironment {
  init() { }
}

let sheetReducer = Reducer<SheetState, SheetAction, SheetEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.detailState,
      action: /SheetAction.detailAction,
      environment: { _ in DetailEnvironment() }
    ),
  
  Reducer<SheetState, SheetAction, SheetEnvironment> { state, action, environment in
    switch action {
    // UserAction
    case .didTapPresent(true):
      return Effect.concatenate([
        Effect(value: ._setIsPresent),
        Effect(value: ._createDetailState)
      ])
      
    case .didTapPresent(false):
      return Effect.concatenate([
        Effect(value: ._setIsNotPresent),
        Effect(value: ._deleteDetailState)
      ])
      
    // Inner Action
    case ._setIsPresent:
      state.isPresent = true
      return .none
      
    case ._setIsNotPresent:
      state.isPresent = false
      return .none
      
    case ._createDetailState:
      state.detailState = DetailState(editMode: false)
      return .none
      
    case ._deleteDetailState:
      state.detailState = nil
      return .none
      
    // Child Action
    case .detailAction(.didDoneTap):
      guard let detail = state.detailState else { return .none }
      state.createdProject = Project(
        title: detail.title,
        date: detail.deadLineDate,
        description: detail.description
      )
      return Effect.concatenate([
        Effect(value: ._setIsNotPresent),
        Effect(value: ._deleteDetailState)
      ])
      
    case .detailAction(.didCancelTap):
      return Effect.concatenate([
        Effect(value: ._setIsNotPresent),
        Effect(value: ._deleteDetailState)
      ])
      
    case .detailAction:
      return .none
    }
  }
])
