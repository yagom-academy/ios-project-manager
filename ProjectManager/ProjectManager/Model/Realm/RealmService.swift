//
//  RealmService.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/14.
//

import RealmSwift

final class RealmService {
  private let realm = try? Realm()

  func create<T: Object>(project: T) {
    do {
      try realm?.write {
        realm?.add(project)
      }
    } catch {
      print(error)
    }
  }

  func read<T: Object>(projectType: T.Type) -> Results<T>? {
    return realm?.objects(projectType)
  }

  func update(uuid: String, title: String, body: String, date: Date) {
    let predicate = NSPredicate(format: "uuid == %@", uuid)
    guard let project = realm?.objects(Project.self).filter(predicate).first else { return }

    do {
      try realm?.write {
        project.title = title
        project.body = body
        project.date = date
      }
    } catch {
      print(error)
    }
  }

  func delete<T: Object>(project: T) {
    do {
      try realm?.write {
        realm?.delete(project)
      }
    } catch {
      print(error)
    }
  }

  func deleteAll() {
    do {
      try realm?.write {
        realm?.deleteAll()
      }
    } catch {
      print(error)
    }
  }
}
