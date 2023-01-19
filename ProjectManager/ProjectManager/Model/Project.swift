//
//  Project.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import ComposableArchitecture

struct Project: Decodable, Identifiable, Equatable {
  var id: UUID = UUID()
  let title: String
  let date: Int
  let description: String
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

extension Project {
  static let todoMockData: [Self] = [
    .init(title: "0", date: 0, description: "0"),
    .init(title: "1", date: 0, description: "1"),
    .init(title: "2", date: 0, description: "2"),
    .init(title: "3", date: 0, description: "3"),
    .init(title: "4", date: 0, description: "4"),
    .init(title: "5", date: 0, description: "5"),
  ]
}
