//
//  RealmService.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/14.
//

import RealmSwift

final class RealmService {
  private let realm = try? Realm()
  private var notificationToken: NotificationToken?

  func invalidateNotificationToken() {
    self.notificationToken?.invalidate()
  }

  func makeRealmObserve(_ handler: @escaping () -> Void) {
    self.notificationToken = realm?.observe { (_, _) in
      handler()
    }
  }

  func create<T: Object>(project: T) {
    do {
      try realm?.write {
        realm?.add(project)
      }
    } catch {
      print(error)
    }
  }

  func readAll<T: Object>(projectType: T.Type) -> Results<T>? {
    return realm?.objects(projectType)
  }

  func readTarget<T: Object>(uuid: String, projectType: T.Type) -> T? {
    let predicate = NSPredicate(format: "uuid == %@", uuid)
    let project = realm?.objects(projectType).filter(predicate).first

    return project
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

  func updateProjectCategory(uuid: String, moveCategory: String) {
    let predicate = NSPredicate(format: "uuid == %@", uuid)
    guard let project = realm?.objects(Project.self).filter(predicate).first else { return }

    do {
      try realm?.write {
        project.projectCategory = moveCategory
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

  func filter(projectCategory: ProjectCategory) -> Results<Project>? {
    let predicate = NSPredicate(format: "projectCategory == %@", projectCategory.description)
    let filteringResult = realm?.objects(Project.self).filter(predicate)

    return filteringResult
  }
}
