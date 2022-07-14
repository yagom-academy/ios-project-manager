//
//  LocalDB.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation
import RealmSwift

final class RealmService: Realmable {
  private var realm: Realm
  
  init() {
    do {
      realm = try Realm()
    } catch {
      print(error)
    }
    realm = try! Realm()
  }

  func create<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.add(object)
      }
    } catch {
      post(error)
    }
  }
  
  func readAll<T: Object>() -> [T] {
    let data = realm.objects(T.self)
    
    return Array(data)
  }
  
  func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
    do {
      try realm.write {
        for (key, value) in dictionary {
          object.setValue(value, forKey: key)
        }
      }
    } catch {
      post(error)
    }
  }
  
  func delete<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.delete(object)
      }
    } catch {
      post(error)
    }
  }
  
  func post(_ error: Error) {
    NotificationCenter.default.post(name: Notification.Name("RealmError"), object: error)
  }
  
  func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
    NotificationCenter.default.addObserver(
      forName: Notification.Name("RealmError"),
      object: nil,
      queue: nil) { notification in
        completion(notification.object as? Error)
      }
  }
  
  func stopObservingErrors(in vc: UIViewController) {
    NotificationCenter.default.removeObserver(vc, name: Notification.Name("RealmError"), object: nil)
  }
}
