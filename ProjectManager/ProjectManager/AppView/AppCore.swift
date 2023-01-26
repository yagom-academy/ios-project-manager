//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct AppState: Equatable {
  var sheetState = SheetState()
  var todoListState = BoardListState(status: .todo)
  var doingListState = BoardListState(status: .doing)
  var doneListState = BoardListState(status: .done)
}

enum AppAction {
  // User Action
  case sheetAction(SheetAction)

  // Inner Action
//  case _movingTodo(Project)
//  case _movingDoing(Project)
//  case _movingDone(Project)
  
  // Child Action
  case todoListAction(BoardListAction)
  case doingListAction(BoardListAction)
  case doneListAction(BoardListAction)
}

struct AppEnvironment {
  init() { }
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine([
  sheetReducer
    .pullback(
      state: \.sheetState,
      action: /AppAction.sheetAction,
      environment: { _ in SheetEnvironment() }
    ),
  
  boardListReducer
    .pullback(
      state: \.todoListState,
      action: /AppAction.todoListAction,
      environment: { _ in BoardListEnvironment() }
    ),
  
  boardListReducer
    .pullback(
      state: \.doingListState,
      action: /AppAction.doingListAction,
      environment: { _ in BoardListEnvironment() }
    ),
  
  boardListReducer
    .pullback(
      state: \.doneListState,
      action: /AppAction.doneListAction,
      environment: { _ in BoardListEnvironment() }
    ),
  
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .sheetAction(.detailAction(.didDoneTap)):
      guard let project = state.sheetState.createdProject else { return .none }
      state.todoListState.projects.append(project)
      return .none
      
    case .sheetAction:
      return .none
      
    case let .todoListAction(.movingToDoing(project)):
      state.doingListState.projects.append(project)
      return .none
      
    case let .todoListAction(.movingToDone(project)):
      state.doneListState.projects.append(project)
      return .none

    case let .doingListAction(.movingToTodo(project)):
      state.todoListState.projects.append(project)
      return .none
      
    case let .doingListAction(.movingToDone(project)):
      state.doneListState.projects.append(project)
      return .none
      
    case let .doneListAction(.movingToTodo(project)):
      state.todoListState.projects.append(project)
      return .none
      
    case let .doneListAction(.movingToDoing(project)):
      state.doingListState.projects.append(project)
      return .none
      
    case .todoListAction:
      return .none
      
    case .doingListAction:
      return .none
      
    case .doneListAction:
      return .none
    }
  }
]).debug()
