//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct AppState: Equatable {
  var navigateState = NavigateState()
  var todoListState = TodoState()
  var doingListState = DoingState()
  var doneListState = DoneState()
}

enum AppAction {
  case navigateAction(NavigateAction)
  case todoListAction(TodoAction)
  case doingListAction(DoingAction)
  case doneListAction(DoneAction)
  
  case _movingTodo(Project)
  case _movingDoing(Project)
  case _movingDone(Project)
}

struct AppEnvironment {
  init() { }
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine([
  navigateReducer
    .pullback(
      state: \.navigateState,
      action: /AppAction.navigateAction,
      environment: { _ in NavigateEnvironment() }
    ),
  TodoReducer
    .pullback(
      state: \.todoListState,
      action: /AppAction.todoListAction,
      environment: { _ in TodoEnvironment() }
    ),
  
  DoingReducer
    .pullback(
      state: \.doingListState,
      action: /AppAction.doingListAction,
      environment: { _ in DoingEnvironment() }
    ),
  
  DoneReducer
    .pullback(
      state: \.doneListState,
      action: /AppAction.doneListAction,
      environment: { _ in DoneEnvironment() }
    ),
  
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .navigateAction(.detailAction(.didDoneTap)):
      guard let project = state.navigateState.createdProject else { return .none }
      state.todoListState.projects.append(project)
      return .none
      
    case .navigateAction:
      return .none
      
    case let .todoListAction(.movingToDoing(project)):
      return Effect(value: ._movingDoing(project))
      
    case let .todoListAction(.movingToDone(project)):
      return Effect(value: ._movingDone(project))
      
    case .todoListAction:
      return .none
      
    case let .doingListAction(.movingToTodo(project)):
      return Effect(value: ._movingTodo(project))
      
    case let .doingListAction(.movingToDone(project)):
      return Effect(value: ._movingDone(project))
      
    case .doingListAction:
      return .none
      
    case let .doneListAction(.movingToDoing(project)):
      return Effect(value: ._movingDoing(project))
      
    case let .doneListAction(.movingToTodo(project)):
      return Effect(value: ._movingTodo(project))
      
    case .doneListAction:
      return .none
      
    case let ._movingTodo(project):
      state.todoListState.projects.append(project)
      return .none
      
    case let ._movingDoing(project):
      state.doingListState.projects.append(project)
      return .none
      
    case let ._movingDone(project):
      state.doneListState.projects.append(project)
      return .none
    }
  }
])
