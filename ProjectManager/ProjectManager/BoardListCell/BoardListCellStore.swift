//
//  BoardListCellStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct BoardListCellStore: ReducerProtocol {
  struct State: Equatable, Identifiable {
    var status: ProjectState? = .todo
    var isSelected: Bool = false
    let id: UUID
    var project: Project
    var detailState: DetailViewStore.State?
  }
  
  enum Action: Equatable {
    case didChangeState(ProjectState)
    case didSelectedEdit(Bool)
    case optionalDetailState(DetailViewStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .didChangeState:
        return .none
        
      case .didSelectedEdit(true):
        state.isSelected = true
        state.detailState = DetailViewStore.State(
          title: state.project.title,
          description: state.project.description,
          deadLineDate: state.project.date.convertedDate
        )
        return .none
        
      case .didSelectedEdit(false):
        state.isSelected = false
        state.detailState = nil
        return .none
        
      case .optionalDetailState(.didTapCancelButton):
        state.isSelected = false
        return .none
        
      case .optionalDetailState(.binding):
        return .none
        
      case .optionalDetailState(.didTapDoneButton):
        guard let detail = state.detailState else {
          return .none
        }
        state.project.title = detail.title
        state.project.date = Int(detail.deadLineDate.timeIntervalSince1970)
        state.project.description = detail.description
        
        state.isSelected = false
        
        return .none
      }
    }
    .ifLet(\.detailState, action: /Action.optionalDetailState) {
      DetailViewStore()
    }
  }
}
