//
//  DetailViewStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DetailState: Equatable {
  var title: String = ""
  var description: String = ""
  var deadLineDate: Date = Int(Date().timeIntervalSince1970).convertedDate
}

enum DetailAction {
  // User Action
  case didCancelTap
  case didDoneTap
  
  // Inner Action
  case _didChangeTitle(String)
  case _didChangeDescription(String)
  case _didChangeDeadLine(Date)
}

struct DetailEnvironment {
  init() { }
}

let detailReducer = Reducer<DetailState, DetailAction, DetailEnvironment> { state, action, environment in
  switch action {
  case .didCancelTap:
    return .none
    
  case .didDoneTap:
    return .none
    
  case let ._didChangeTitle(changedTitle):
    state.title = changedTitle
    return .none
    
  case let ._didChangeDescription(changedDescription):
    state.description = changedDescription
    return .none
    
  case let ._didChangeDeadLine(changedDate):
    state.deadLineDate = Int(changedDate.timeIntervalSince1970).convertedDate
    return .none
  }
}
