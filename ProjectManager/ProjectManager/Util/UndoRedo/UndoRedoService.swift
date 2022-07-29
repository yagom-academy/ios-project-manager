//
//  UndoRedoService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/29.
//

protocol UndoRedoService {
  var undoStack: [History] { get }
  var redoStack: [History] { get }
  
  func take(history: History)
  func undo() -> History?
  func redo() -> History?
}
