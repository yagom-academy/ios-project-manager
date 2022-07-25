//
//  Originator.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

import Foundation

protocol Originatable {
  var memento: Memento? { get set }
  var history: CareTaker { get set }
  
  mutating func createMemento(_ memento: Memento)
  mutating func undo()
  mutating func redo()
}

class Originator: Originatable {
  static let shared = Originator()
  private init() {}
  
  var memento: Memento?
  var history = CareTaker()
  
  func createMemento(_ memento: Memento) {
    self.memento?.make(memento.memento)
    
    guard let unwrappedMemento = self.memento else {
      return
    }
    
    history.save(unwrappedMemento)
  }
  
  func undo() {
    history.undo()
  }
  
  func redo() {
    history.redo()
  }
}
