//
//  BoardListStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BoardListStore: ReducerProtocol {
  struct State: Equatable {
    @BindableState var selectedProject = Set<Project.ID>()
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
  
  enum Action: BindableAction, Equatable {
    //MARK: 삭제 예정
    case binding(BindingAction<State>)
    case deleteProject(IndexSet)
    case optionalHeader(BoardHeaderStore.Action)
    case projectItem(id: BoardListCellStore.State.ID, action: BoardListCellStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .optionalHeader:
        return .none
        
      case let .deleteProject(indexSet):
        indexSet.forEach { state.projects.remove(at: $0) }
        return .none
        
      case .projectItem:
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

