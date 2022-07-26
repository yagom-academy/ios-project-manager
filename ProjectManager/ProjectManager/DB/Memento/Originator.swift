//
//  Originator.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

protocol Originatable {
  var memento: Memento? { get set }
  var careTaker: CareTaker { get set }
  
  mutating func createMemento(_ memento: Memento)
  mutating func undo()
  mutating func redo()
}

final class Originator: Originatable {
  static let shared = Originator()
  private init() {}
  
  var memento: Memento?
  var careTaker = CareTaker()
  
  func createMemento(_ memento: Memento) {
    self.memento = memento
    
    guard let unwrappedMemento = self.memento else {
      return
    }
    
    careTaker.save(unwrappedMemento)
  }
  
  func undo() {
    careTaker.undo()
  }
  
  func redo() {
    careTaker.redo()
  }
}
