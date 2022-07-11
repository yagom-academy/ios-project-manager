//
//  ProjectList.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/12.
//

import Foundation

enum projectCategory {
  case todo
  case doing
  case done

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

struct ProjectList {
  let title: String
  let body: String
  let date: Date
  let projectCategory: projectCategory
}
