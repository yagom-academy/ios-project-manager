//
//  Project.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

struct Project: Decodable {
  let title: String
  let date: Int
  let description: String
  var state: ProjectState = .todo
  
  static let mock: [Project] = [
    .init(title: "책상 정리", date: 1000000, description: "집중이 안될때는 역시나 책상 정리"),
    .init(title: "책상 정리2", date: 1000000, description: "집중이 안될때는 역시나 책상 정리2"),
    .init(title: "책상 정리3", date: 1000000, description: "집중이 안될때는 역시나 책상 정리3"),
    .init(title: "책상 정리4", date: 1000000, description: "집중이 안될때는 역시나 책상 정리4"),
  ]
}

enum ProjectState: Int, CaseIterable, Decodable {
  case todo = 1
  case doing = 2
  case done = 3
}
