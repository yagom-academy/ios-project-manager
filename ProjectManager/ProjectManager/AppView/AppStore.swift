//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct AppStore: ReducerProtocol {
  struct State: Equatable {
    var navigationState = NavigationStore.State()
    var boardState = BoardStore.State()
  }
  
  enum Action: Equatable {
    case onAppear
    case presentSheet(NavigationStore.Action)
    case boardView(BoardStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.navigationState, action: /Action.presentSheet) {
      NavigationStore()
    }
    
    Scope(state: \.boardState, action: /Action.boardView) {
      BoardStore()
    }
    
    Reduce { state, action in
      switch action {
      case .onAppear:
        state = .init()
        return .none

      case .presentSheet(.onAppear(_)):
        return .none
        
      case .presentSheet(.didTapPresent(_)):
        return .none
        
      case .presentSheet(.optionalDetailState(_)):
        return .none
        
      case .presentSheet(.completionCreate):
        guard let createdProject = state.navigationState.createdProject else {
          return .none
        }
        let cellState = BoardListCellStore.State(id: UUID(), project: createdProject)
        state.boardState.todoState.projects.updateOrAppend(cellState)
        return .none
        
      case .boardView:
        return .none
      }
    }
  }
}
