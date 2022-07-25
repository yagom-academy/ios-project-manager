//
//  ProjectCategory.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

enum ProjectCategory {
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
