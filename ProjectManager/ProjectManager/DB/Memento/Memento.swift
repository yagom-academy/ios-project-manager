//
//  Memento.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/25.
//

protocol Mementoable {
  var todo: Todo { get set }
  var historyState: HistoryState { get set }
  var toState: State? { get set }
}

struct Memento: Mementoable {
  var todo: Todo
  var historyState: HistoryState
  var toState: State?
}
