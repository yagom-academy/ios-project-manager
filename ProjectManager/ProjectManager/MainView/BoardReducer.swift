//
//  BoardReducer.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardReducer: ReducerProtocol {
  struct State: Equatable {
    var isPresentEditView: Bool = false
    var projects: [Project] = Project.mock
  }
  
  enum Action: Equatable {
    case didTapPresentEdit
    case didDismissEditView
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didTapPresentEdit:
      state.isPresentEditView = true
      return .none
      
    case .didDismissEditView:
      state.isPresentEditView = false
      return .none
    }
  }
}
