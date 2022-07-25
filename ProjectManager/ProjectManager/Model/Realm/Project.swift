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

  convenience init(
    uuid: String,
    title: String,
    body: String?,
    date: Date,
    projectCategory: String
  ) {
    self.init()
    self.uuid = uuid
    self.title = title
    self.body = body
    self.date = date
    self.projectCategory = projectCategory
  }

  override static func primaryKey() -> String? {
    return "uuid"
  }
}
