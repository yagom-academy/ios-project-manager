//
//  BoardListStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BoardListStore: ReducerProtocol {
  struct State: Equatable {
    @BindableState var isPresent: Bool = false
    var status: ProjectState
    var headerState: BoardHeaderStore.State
    var selectedListCellState: BoardListCellStore.State?
    
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
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case deleteProject(IndexSet)
    case setPresentMode(Bool, BoardListCellStore.State.ID?)
    case optionalCellState(BoardListCellStore.Action)
    case optionalHeader(BoardHeaderStore.Action)
    case projectItem(id: BoardListCellStore.State.ID, action: BoardListCellStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case let .setPresentMode(true, id):
        guard let id = id else { return .none }
        
        state.isPresent = true
        let filteredDatas = state.projects.filter { $0.id == id }
        guard let firstElement = filteredDatas.first else { return .none }
        state.selectedListCellState = firstElement
        return .none
        
      case .setPresentMode(false, _):
        state.isPresent = false
        return .none
        
      case .optionalHeader:
        return .none
        
      case let .deleteProject(indexSet):
        indexSet.forEach { state.projects.remove(at: $0) }
        return .none
        
      case .optionalCellState:
        return .none
        
      case .projectItem:
        return .none

      }
    }.forEach(\.projects, action: /Action.projectItem(id:action:)) {
      BoardListCellStore()
    }.ifLet(\.selectedListCellState, action: /Action.optionalCellState) {
      BoardListCellStore()
    }
    
    Scope(state: \.headerState, action: /Action.optionalHeader) {
      BoardHeaderStore()
    }
  }
}

