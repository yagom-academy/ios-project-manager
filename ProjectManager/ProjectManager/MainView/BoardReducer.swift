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
    case optionalDetailViewState(DetailViewReducer.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .didSetProject(canEdit):
        state.detailViewState = DetailViewReducer.State(canEdit: canEdit)
        state.isPresent.toggle()
        return .none
      case .optionalDetailViewState:
        return .none
      }
    }.ifLet(\.detailViewState, action: /Action.optionalDetailViewState) {
      DetailViewReducer()
    }
  }
  
}
