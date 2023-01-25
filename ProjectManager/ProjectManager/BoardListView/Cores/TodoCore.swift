//
//  TodoCore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct TodoState: Equatable {
  var projects: [Project] = []
  
  var selectedProject: Project?
  var selectedState: DetailState?
}

enum TodoAction {
  // User Action
  case didDelete(IndexSet)
  case movingToDoing(Project)
  case movingToDone(Project)
  
  case detailAction(DetailAction)
  
  // Inner Action
  case _setSelectedState(Project?)
}

struct TodoEnvironment {
  init() { }
}

let todoReducer = Reducer<TodoState, TodoAction, TodoEnvironment>.combine([
  detailReducer
    .optional()
    .pullback(
      state: \.selectedState,
      action: /TodoAction.detailAction,
      environment: { _ in DetailEnvironment()}
    ),
  Reducer<TodoState, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case let .didDelete(indexSet):
      indexSet.forEach { state.projects.remove(at: $0) }
      return .none
      
    case let .movingToDoing(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let .movingToDone(project):
      state.projects.removeAll(where: { $0 == project })
      return .none
      
    case let ._setSelectedState(project):
      guard let project = project else {
        state.selectedState = nil
        state.selectedProject = nil
        return .none
      }
      
      state.selectedProject = project
      state.selectedState = DetailState(
        id: project.id,
        title: project.title,
        description: project.description,
        deadLineDate: project.date,
        editMode: true
      )
      
      return .none
      
    case .detailAction(.didDoneTap):
      guard let selectedItem = state.selectedProject,
            let index = state.projects.firstIndex(of: selectedItem),
            let detail = state.selectedState else {
        return .none
      }
      
      let newItem = Project(
        title: detail.title,
        date: detail.deadLineDate,
        description: detail.description
      )
      state.projects[index] = newItem
      
      return Effect(value: ._setSelectedState(nil))
      
    case .detailAction(.didCancelTap):
      return Effect(value: ._setSelectedState(nil))
      
    case .detailAction:
      return .none
    }
  }
])
