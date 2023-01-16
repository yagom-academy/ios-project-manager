//
//  AppStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct AppStore: ReducerProtocol {
  struct State: Equatable {
    var navigationState = NavigationStore.State()
  }
  
  enum Action: Equatable {
    case onAppear
    case presentSheet(NavigationStore.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state = .init()
        return .none
        
      default:
        return .none
      }
    }
    
    Scope(state: \.navigationState, action: /Action.presentSheet) {
      NavigationStore()
    }
  }
}
