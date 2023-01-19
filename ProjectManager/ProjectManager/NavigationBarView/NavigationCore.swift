//
//  NavigationStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct NavigateState: Equatable {
  var isPresent: Bool = false
  var title: String = "Project Manager"
  var detailState: DetailState?
  
  var createdProject: Project?
}

enum NavigateAction {
  // User Action
  case didTapPresent(Bool)
  case detailAction(DetailAction)
  
  // Inner Action
  case _toggleNavigationState(Bool)
}

struct NavigateEnvironment {
  init() { }
}

let navigateReducer = Reducer<NavigateState, NavigateAction, NavigateEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.detailState,
      action: /NavigateAction.detailAction,
      environment: { _ in DetailEnvironment() }
    ),
  
  Reducer<NavigateState, NavigateAction, NavigateEnvironment> { state, action, environment in
    switch action {
    case let .didTapPresent(isPresent):
      if state.isPresent != isPresent {
        return Effect(value: ._toggleNavigationState(isPresent))
      } else {
        return .none
      }
      
    case let ._toggleNavigationState(isPresent):
      state.isPresent = isPresent
      state.detailState = DetailState()
      return .none
      
    case .detailAction(.didDoneTap):
      guard let detail = state.detailState else { return .none }
      state.createdProject = Project(
        title: detail.title,
        date: Int(detail.deadLineDate.timeIntervalSince1970),
        description: detail.description
      )
      return Effect(value: .didTapPresent(false))
      
    case .detailAction:
      return .none
    }
  }
])
