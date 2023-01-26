//
//  DetailCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DetailState: Equatable, Identifiable {
  let id: UUID
  let projectStatus: ProjectState
  
  var title: String
  var description: String
  var deadLineDate: Date
  var editMode: Bool
  
  var isEditMode: Bool = false
  
  init(
    id: UUID = UUID(),
    projectStatus: ProjectState = .todo,
    title: String = "",
    description: String = "",
    deadLineDate: Date = Date(),
    editMode: Bool = false
  ) {
    self.id = id
    self.projectStatus = projectStatus
    self.title = title
    self.description = description
    self.deadLineDate = deadLineDate
    self.editMode = editMode
    self.isEditMode = !editMode
  }
}

enum DetailAction {
  // User Action
  case didCancelTap
  case didEditTap
  case didDoneTap
  
  // Inner Action
  case _setNewTitle(String)
  case _setNewDescription(String)
  case _setNewDeadLine(Date)
}

struct DetailEnvironment {
  init() { }
}

let detailReducer = Reducer<DetailState, DetailAction, DetailEnvironment> { state, action, environment in
  switch action {
  case .didEditTap:
    state.isEditMode.toggle()
    return .none
    
  case .didCancelTap:
    return .none
    
  case .didDoneTap:
    return .none
    
  case let ._setNewTitle(changedTitle):
    state.title = changedTitle
    return .none
    
  case let ._setNewDescription(changedDescription):
    state.description = changedDescription
    return .none
    
  case let ._setNewDeadLine(changedDate):
    state.deadLineDate = changedDate
    return .none
  }
}
