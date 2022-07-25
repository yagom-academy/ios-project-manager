//
//  ToDo.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.

import Foundation
import RealmSwift

struct Todo: Hashable, Identifierable {
  var id: String = UUID().uuidString
  var title: String
  var content: String
  var date: Date
  var state: State = .todo
}
