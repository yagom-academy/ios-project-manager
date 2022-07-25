//
//  Memento.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

import Foundation

protocol Mementoable {
  associatedtype Element
  
  var memento: Element { get set }
  
  mutating func make(_ memento: Element)
}

struct Memento: Mementoable {
  typealias Element = Todo
  
  var memento: Todo
  
  mutating func make(_ memento: Todo) {
    self.memento = memento
  }
}
