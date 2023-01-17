//
//  NavigationStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct NavigationStore: ReducerProtocol {
  struct State: Equatable {
    var isPresent: Bool = false
    var title: String = ""
    var trailingImage: Image?
    var leadingImage: Image?
    var detailState: DetailViewStore.State?
    var createdProject: Project?
  }
  
  enum Action: Equatable {
    case onAppear(String)
    case didTapPresent(Bool)
    case completionCreate
    case optionalDetailState(DetailViewStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .onAppear(titleValue):
        state.title = titleValue
        return .none
        
      case .didTapPresent(true):
        state.isPresent = true
        state.detailState = DetailViewStore.State()
        return .none
        
      case .didTapPresent(false):
        state.isPresent = false
        state.detailState = nil
        return .none
        
      case .optionalDetailState(.didTapDoneButton):
        return .task {
          return .completionCreate
        }
        
      case .optionalDetailState(.binding):
        return .none
        
      case .optionalDetailState(.didTapCancelButton):
        state.detailState = nil
        state.isPresent = false
        return .none
        
      case .completionCreate:
        guard let detailState = state.detailState else { return .none }
        let project = Project(
          title: detailState.title,
          date: detailState.deadLineDate.timeIntervalSince1970.exponent,
          description: detailState.description
        )
        state.createdProject = project
        state.isPresent = false
        return .none
      }
    }
    .ifLet(\.detailState, action: /Action.optionalDetailState) {
      DetailViewStore()
    }
  }
}
