//
//  Identifiable.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}
