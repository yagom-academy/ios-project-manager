//
//  Project.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct Project: Decodable, Identifiable, Equatable {
  var id: UUID = UUID()
  var title: String
  var date: Int
  var description: String
  var state: ProjectState = .todo
}

enum ProjectState: Int, CaseIterable, Decodable {
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
    @unknown default:
      return ""
    }
  }
}
