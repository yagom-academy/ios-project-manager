//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12.
//

import Foundation

class TodoViewModel: NSObject {
  let todo = Todo()
  let todoList: [Todo]?
  
  override init() {
    todoList = todo.readList
  }
}
