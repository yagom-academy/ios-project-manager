//
//  History.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

import Foundation

protocol Historyable {
  var stateList: [Memento] { get set }
  var garbageStateList: [Memento] { get }
  
  mutating func save(_ memento: Memento)
  mutating func undo()
  mutating func redo()
  func readStateList() -> [Memento]
}

struct History: Historyable {
  var stateList = [Memento]()
  var garbageStateList = [Memento]()
  
  mutating func save(_ memento: Memento) {
    stateList.append(memento)
  }
  
  mutating func undo() {
    guard let lastState = stateList.popLast() else {
      return
    }
    
    garbageStateList.append(lastState)
  }
  
  mutating func redo() {
    guard let lastState = garbageStateList.popLast() else {
      return
    }
    
    stateList.append(lastState)
  }
  
  func readStateList() -> [Memento] {
    return stateList
  }
}
