//
//  Realmable.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/09.
//

import UIKit
import RealmSwift

protocol Realmable {
  func create<T: Object>(_ object: T)
  func readAll<T: Object>() -> [T]
  func update<T: Object>(_ object: T, with dictionary: [String: Any?])
  func delete<T: Object>(_ object: T)
}
