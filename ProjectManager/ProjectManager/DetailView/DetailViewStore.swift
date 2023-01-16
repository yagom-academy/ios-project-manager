//
//  DetailViewStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DetailViewStore: ReducerProtocol {
  struct State: Equatable {
    var title: String = ""
    var description: String = ""
    var deadLineDate: Date = Date()
  }
  
  enum Action {
    case didChangeTitle(String)
    case didChangeDescription(String)
    case didChangeSelectedDate(Date)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .didChangeDescription(changedDescription):
      state.description = changedDescription
      return .none
      
    case let .didChangeTitle(changedTitle):
      state.title = changedTitle
      return .none
      
    case let .didChangeSelectedDate(changedDate):
      state.deadLineDate = changedDate
      return .none
    }
  }
}
