//
//  BoardListCellStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct BoardListCellStore: ReducerProtocol {
  struct State: Equatable, Identifiable {
    let id: UUID
    let project: Project
  }
  
  enum Action: Equatable {
    case longTapEnded
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .longTapEnded:
      return .none
    }
  }
}
