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
  
  //MARK: 임시 데이터 추후 삭제 예정
  static let mock: IdentifiedArrayOf<BoardListCellStore.State> = [
    .init(
      status: .todo,
      id: UUID(),
      project: .init(
        title: "책상 정리",
        date: 1000000,
        description: "집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리 집중이 안될때는 역시나 책상 정리"
      )
    ),
    .init(
      status: .doing,
      id: UUID(),
      project: .init(
        title: "책상 정리2",
        date: 1000000,
        description: "집중이 안될때는 역시나 책상 정리2",
        state: .doing)
    ),
    .init(
      status: .done,
      id: UUID(),
      project: .init(
        title: "책상 정리3",
        date: 1000000,
        description: "집중이 안될때는 역시나 책상 정리3"
      )
    ),
    .init(
      status: .doing,
      id: UUID(),
      project: .init(
        title: "책상 정리4",
        date: 1000000,
        description: "집중이 안될때는 역시나 책상 정리4",
        state: .done
      )
    )
  ]
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
