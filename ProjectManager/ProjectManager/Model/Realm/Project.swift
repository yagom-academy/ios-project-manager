//
//  Project.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/14.
//

import RealmSwift

final class Project: Object {
  @objc dynamic var uuid: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var body: String?
  @objc dynamic var date: Date = Date()
  @objc dynamic var projectCategory: String = ""

  override static func primaryKey() -> String? {
    return "uuid"
  }
}
