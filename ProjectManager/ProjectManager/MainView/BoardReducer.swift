//
//  BoardReducer.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardReducer: ReducerProtocol {
  struct State: Equatable {
    var isPresent: Bool = false
    var projects: [Project] = Project.mock
  }
  
  enum Action: Equatable {
    case didSetProject(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .didSetProject(isPresented):
      state.isPresent = isPresented
      return .none
    }
  }
}
