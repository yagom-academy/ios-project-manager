//
//  Originator.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

import Foundation

protocol Originatable {
  var memento: Memento? { get set }
  var history: History { get set }
  
  mutating func createMemento(_ memento: Memento)
  mutating func undo()
  mutating func redo()
}

struct Originator: Originatable {
  var memento: Memento?
  var history = History()
  
  mutating func createMemento(_ memento: Memento) {
    self.memento?.make(memento.memento)
    
    guard let unwrappedMemento = self.memento else {
      return
    }
    
    history.save(unwrappedMemento)
  }
  
  mutating func undo() {
    history.undo()
  }
  
  mutating func redo() {
    history.redo()
  }
}
