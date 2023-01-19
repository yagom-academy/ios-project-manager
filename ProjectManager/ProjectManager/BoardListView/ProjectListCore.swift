//
//  BoardListStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct ProjectListState: Equatable {
  var projects: [Project] = []
}

enum ProjectListAction: Equatable {
  case didDelete(IndexSet)
}

struct ProjectListEnvironment {
  init() { }
}

let projectListReducer = Reducer<ProjectListState, ProjectListAction, ProjectListEnvironment> { state, action, environment in
  switch action {
  case let .didDelete(index):
    index.forEach { state.projects.remove(at: $0) }
    return .none
  }
}
