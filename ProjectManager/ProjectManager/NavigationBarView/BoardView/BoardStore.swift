//
//  BoardState.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct BoardStore: ReducerProtocol {
  struct State: Equatable {
    var todoState = BoardListStore.State(status: .todo, projects: [])
    var doingState = BoardListStore.State(status: .doing, projects: [])
    var doneState = BoardListStore.State(status: .done, projects: [])
  }
  
  enum Action: Equatable {
    case todo(BoardListStore.Action)
    case doing(BoardListStore.Action)
    case done(BoardListStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .todo:
        return .none
        
      case .doing:
        return .none
        
      case .done:
        return .none
      }
    }
    
    Scope(state: \.todoState, action: /Action.todo) {
      BoardListStore()
    }
    
    Scope(state: \.doingState, action: /Action.doing) {
      BoardListStore()
    }
    
    Scope(state: \.doneState, action: /Action.done) {
      BoardListStore()
    }
  }
}
