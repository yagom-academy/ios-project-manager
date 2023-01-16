//
//  BoardHeaderStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct BoardHeaderStore: ReducerProtocol {
  struct State: Equatable {
    var count: Int
    var projectStatus: ProjectState
    
    var length: Int {
      return count.description.count
    }
  }
  
  enum Action: Equatable {
    case onAppear(count: Int, status: ProjectState)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .onAppear(count, status):
      state.count = count
      state.projectStatus = status
      return .none
    }
  }
}
