//
//  State.swift
//  ProjectManager
//
//  Created by song on 2022/07/20.
//

import RealmSwift

enum Status: String, PersistableEnum {
  case todo = "TODO"
  case doing = "DOING"
  case done = "DONE"
}
