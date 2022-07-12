//
//  RealmModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12.
//

import RealmSwift

class TodoModel: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var content: String = ""
  @objc dynamic var date: Date = Date.now
  @objc dynamic var state: String = ""
  @objc dynamic var identifier: String = ""
}
