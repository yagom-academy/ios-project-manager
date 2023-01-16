//
//  BoardListStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BoardListStore: ReducerProtocol {
  struct State: Equatable {
    var projects: IdentifiedArrayOf<BoardListCellStore.State> = []
    
    init(projects: IdentifiedArrayOf<BoardListCellStore.State>) {
      self.projects = projects
    }
  }
  
  enum Action: Equatable {
    //MARK: 삭제 예정
    case onAppear(BoardListCellStore.Action)
    case projectItem(id: BoardListCellStore.State.ID, action: BoardListCellStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
        
      default:
        return .none
      }
    }.forEach(\.projects, action: /Action.projectItem(id:action:)) {
      BoardListCellStore()
    }
  }
}
