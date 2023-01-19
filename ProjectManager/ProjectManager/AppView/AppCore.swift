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
      
    case let .todoListAction(.movingToDoing(id)):
      guard let index = state.todoListState.projects.firstIndex(where: { $0.id == id }) else {
        return .none
      }
      let project = state.todoListState.projects.remove(at: index)
      state.doingListState.projects.append(project)
      return .none
      
    case let .todoListAction(.movingToDone(id)):
      guard let index = state.todoListState.projects.firstIndex(where: { $0.id == id }) else {
        return .none
      }
      let project = state.todoListState.projects.remove(at: index)
      state.doneListState.projects.append(project)
      return .none
      
    case .todoListAction:
      return .none
      
    case .doingListAction:
      return .none
      
    case .doneListAction:
      return .none
    }
  }
])
