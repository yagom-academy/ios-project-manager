//
//  Realmable.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/09.
//

import UIKit

protocol DBable {
  associatedtype Element
  
  func create(_ todo: Element)
  func read(by id: String) -> Element
  func readAll() -> [Element]
  func update(_ todo: Element)
  func delete(id: String)
}
