//
//  LocalDB.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation
import RealmSwift

final class RealmService: Realmable {
  private var realm = try? Realm()

  func create<T: Object>(_ object: T) {
    do {
      try realm?.write {
        realm?.add(object)
      }
    } catch {
      print(error)
    }
  }
  
  func readAll<T: Object>() -> [T] {
    guard let data = realm?.objects(T.self) else {
      return [T]()
    }
    
    return Array(data)
  }
  
  func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
    do {
      try realm?.write {
        for (key, value) in dictionary {
          object.setValue(value, forKey: key)
        }
      }
    } catch {
      print(object)
    }
  }
  
  func delete<T: Object>(_ object: T) {
    do {
      try realm?.write {
        realm?.delete(object)
      }
    } catch {
      print(object)
    }
  }
}
