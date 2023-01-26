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
  case _movingTo(targetStatus: ProjectState, newItem: Project)
  
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
      
    case .todoListAction(.movingToDoing(let project)), .doneListAction(.movingToDoing(let project)):
      var newItem = project
      newItem.state = .doing
      return Effect(value: ._movingTo(targetStatus: .doing, newItem: newItem))

    case .todoListAction(.movingToDone(let project)), .doingListAction(.movingToDone(let project)):
      var newItem = project
      newItem.state = .done
      return Effect(value: ._movingTo(targetStatus: .done, newItem: newItem))

    case .doingListAction(.movingToTodo(let project)), .doneListAction(.movingToTodo(let project)):
      var newItem = project
      newItem.state = .todo
      return Effect(value: ._movingTo(targetStatus: .todo, newItem: newItem))
      
    case let ._movingTo(targetStatus, newItem):
      switch targetStatus {
      case .todo:
        state.todoListState.projects.append(newItem)
        return .none
        
      case .doing:
        state.doingListState.projects.append(newItem)
        return .none
        
      case .done:
        state.doneListState.projects.append(newItem)
        return .none
      }
      
    case .todoListAction:
      return .none
      
    case .doingListAction:
      return .none
      
    case .doneListAction:
      return .none
    }
  }
])
