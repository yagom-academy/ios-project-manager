//
//  Identifiable.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

protocol Identifierable {
  static var identifier: String { get }
}

extension Identifierable {
  static var identifier: String {
    return String(describing: self)
  }
}
