//
//  BoardReducer.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardReducer: ReducerProtocol {
  struct State: Equatable {
    var detailViewState: DetailViewReducer.State?
    var isPresent: Bool = false
    var projects: [Project] = Project.mock
  }
  
  enum Action: Equatable {
    case didSetProject(Bool)
    case setDetailViewStore(Bool)
    case optionalDetailViewState(DetailViewReducer.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .didSetProject(isPresent):
        state.isPresent = isPresent
        return .none
        
      case let .setDetailViewStore(canEdit):
        state.detailViewState = DetailViewReducer.State(canEdit: canEdit)
        return .run { send in
          await send(.didSetProject(true))
        }
        
      case .optionalDetailViewState(.dismissButtonTap):
        state.detailViewState = nil
        return .run { send in
          await send(.didSetProject(false))
        }
        
      case .optionalDetailViewState:
        return .none
      }
    }.ifLet(\.detailViewState, action: /Action.optionalDetailViewState) {
      DetailViewReducer()
    }
  }
  
}
