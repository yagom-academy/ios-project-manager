//
//  DefaultUndoRedoService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/29.
//

final class DefaultUndoRedoService: UndoRedoService {
  private(set) var undoStack = [History]()
  private(set) var redoStack = [History]()
  
  func take(history: History) {
    undoStack.append(history)
    redoStack = []
  }
  
  func undo() -> History? {
    guard undoStack.count > .zero, let history = undoStack.popLast() else { return nil }
    redoStack.append(history)
    return history
  }
  
  func redo() -> History? {
    guard redoStack.count > .zero, let history = redoStack.popLast() else { return nil }
    undoStack.append(history)
    return history
  }
}
