//
//  NavigationStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct NavigateState: Equatable {
  var isPresent: Bool = false
  var title: String = "Project Manager"
}

enum NavigateAction {
  // User Action
  case didTapPresent(Bool)
  case detailAction
  
  // Inner Action
  case _toggleNavigationState(Bool)
}

struct NavigateEnvironment {
  init() { }
}

let navigateReducer = Reducer<NavigateState, NavigateAction, NavigateEnvironment> { state, action, environment in
  switch action {
  case let .didTapPresent(isPresent):
    if state.isPresent != isPresent {
      return Effect(value: ._toggleNavigationState(isPresent))
    } else {
      return .none
    }
    
  case .detailAction:
    return .none
    
  case let ._toggleNavigationState(isPresent):
    state.isPresent = isPresent
    return .none
  }
}
