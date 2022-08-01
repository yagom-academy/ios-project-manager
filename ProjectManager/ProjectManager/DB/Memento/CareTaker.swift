//
//  History.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

import Combine

protocol CareTakerable {
  var states: CurrentValueSubject<[Memento], Never> { get set }
  var garbageStates: CurrentValueSubject<[Memento], Never> { get set }
  var stateList: AnyPublisher<[Memento], Never> { get }
  
  mutating func save(_ memento: Memento)
  mutating func undo()
  mutating func redo()
}

struct CareTaker: CareTakerable {
  var states = CurrentValueSubject<[Memento], Never>([])
  var garbageStates = CurrentValueSubject<[Memento], Never>([])
  
  var stateList: AnyPublisher<[Memento], Never> {
    let reversedStates = states.value
    states.send(reversedStates)
    return states.eraseToAnyPublisher()
  }
  
  mutating func save(_ memento: Memento) {
    var savedStates = states.value
    savedStates.append(memento)
    states.send(savedStates)
  }
  
  mutating func undo() {
    var mutableStates = states.value
    var mutableGarbageStates = garbageStates.value
    
    guard let lastState = mutableStates.popLast() else {
      return
    }
    
    states.send(mutableStates)
    
    mutableGarbageStates.append(lastState)
    garbageStates.send(mutableGarbageStates)
  }
  
  mutating func redo() {
    var mutableGarbageStates = garbageStates.value
    var mutableStates = states.value
    
    guard let lastGarbageState = mutableGarbageStates.popLast() else {
      return
    }
    
    garbageStates.send(mutableGarbageStates)
    
    mutableStates.append(lastGarbageState)
    states.send(mutableStates)
  }
  
  private mutating func redoData(_ memento: Memento) {
    if memento.historyState == .removed {
      
    }
  }
}
