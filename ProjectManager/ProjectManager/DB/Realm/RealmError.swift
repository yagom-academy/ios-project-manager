//
//  RealmError.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/18.
//

import Foundation
import UIKit

enum RealmError: Error {
  case objectNotFound
  
  static func addObserver(selector: Selector, vc: UIViewController) {
    NotificationCenter.default.addObserver(vc, selector: selector, name: Notification.Name("RealmError"), object: nil)
  }
  
  static func removeObserver(vc: UIViewController) {
    NotificationCenter.default.removeObserver(vc, name: Notification.Name("RealmError"), object: nil)
  }
}
