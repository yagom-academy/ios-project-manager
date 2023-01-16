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
    case onAppear
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .onAppear:
      return .none
    }
  }
}
