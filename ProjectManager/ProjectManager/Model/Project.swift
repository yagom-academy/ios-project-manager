//
//  Project.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct Project: Codable, Identifiable, Equatable {
  var id = UUID()
  let title: String
  let date: Date
  let description: String
  var state: ProjectState = .todo
}

enum ProjectState: Int, Codable {
  case todo = 1
  case doing = 2
  case done = 3
  
  var description: String {
    switch self {
    case .todo:
      return "TODO"
    case .doing:
      return "DOING"
    case .done:
      return "DONE"
    }
  }
}
