//
//  State.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation

enum State: String, CaseIterable {
  case todo = "TODO"
  case doing = "DOING"
  case done = "DONE"
  
  var moveMessage: String {
    switch self {
    case .todo:
      return "Move To TODO"
    case .doing:
      return "Move To DOING"
    case .done:
      return "Move To DONE"
    }
  }
}
