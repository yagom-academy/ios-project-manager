//
//  BoardState.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct BoardStore: ReducerProtocol {
  struct State: Equatable {
    var todoState = BoardListStore.State(status: .todo, projects: [])
    var doingState = BoardListStore.State(status: .doing, projects: [])
    var doneState = BoardListStore.State(status: .done, projects: [])
    
    var startState: ProjectState?
    var endState: ProjectState?
  }
  
  enum Action: Equatable {
    case todo(BoardListStore.Action)
    case doing(BoardListStore.Action)
    case done(BoardListStore.Action)

    case moveToDatas(datas: IdentifiedArray<UUID, BoardListCellStore.State>)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .todo(.projectItem(id, .didChangeState(status))):
        let datas = state.todoState.projects.filter { $0.id == id }
        state.startState = .todo
        state.endState = status
        return .task {
          return .moveToDatas(datas: datas)
        }
        
      case let .doing(.projectItem(id, .didChangeState(status))):
        let datas = state.doingState.projects.filter { $0.id == id }
        state.startState = .doing
        state.endState = status
        return .task {
          return .moveToDatas(datas: datas)
        }
        
      case let .done(.projectItem(id, .didChangeState(status))):
        let datas = state.doneState.projects.filter { $0.id == id }
        state.startState = .done
        state.endState = status
        return .task {
          return .moveToDatas(datas: datas)
        }
        
      case .todo(.optionalHeader), .todo(.deleteProject):
        return .none
        
      case .doing(.optionalHeader), .doing(.deleteProject):
        return .none
        
      case .done(.optionalHeader), .done(.deleteProject):
        return .none
        
      case let .moveToDatas(datas):
        guard let startState = state.startState,
              let endState = state.endState else {
          return .none
        }
        
        switch startState {
        case .todo:
          datas.forEach { state.todoState.projects.remove($0) }
        case .doing:
          datas.forEach { state.doingState.projects.remove($0) }
        case .done:
          datas.forEach { state.doneState.projects.remove($0) }
        }
        
        switch endState {
        case .todo:
          datas.forEach { state.todoState.projects.updateOrAppend($0) }
        case .doing:
          datas.forEach { state.doingState.projects.updateOrAppend($0) }
        case .done:
          datas.forEach { state.doneState.projects.updateOrAppend($0) }
        }
        
        return .none
        
      default:
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
