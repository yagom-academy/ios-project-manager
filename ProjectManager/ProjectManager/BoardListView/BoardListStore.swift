//
//  BoardListStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BoardListStore: ReducerProtocol {
  struct State: Equatable {
    var status: ProjectState
    var headerState: BoardHeaderStore.State
    var projects: IdentifiedArrayOf<BoardListCellStore.State> = [] {
      didSet {
        headerState.count = projects.count
      }
    }
    
    init(status: ProjectState, projects: IdentifiedArrayOf<BoardListCellStore.State>) {
      self.status = status
      self.projects = projects
      self.headerState = BoardHeaderStore.State(
        count: projects.count,
        projectStatus: status
      )
    }
  }
  
  enum Action: Equatable {
    //MARK: 삭제 예정
    case reloadHeaderStore
    case optionalHeader(BoardHeaderStore.Action)
    case projectItem(id: BoardListCellStore.State.ID, action: BoardListCellStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .reloadHeaderStore:
        state.headerState.count = state.projects.count
        return .none
        
      case .optionalHeader:
        return .none
        
      default:
        return .none
      }
    }.forEach(\.projects, action: /Action.projectItem(id:action:)) {
      BoardListCellStore()
    }
    
    Scope(state: \.headerState, action: /Action.optionalHeader) {
      BoardHeaderStore()
    }
  }
}

