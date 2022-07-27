//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/27.
//

import Foundation
import SwiftUI

class HistoryViewModel: ViewModelType {
  @Published var allHistories: [History] = []
  
  func showHistory() -> String {
    var result: String = ""
    self.allHistories = service.allHistories
    
    allHistories.forEach { history in
      switch history.type {
      case .add, .remove:
        result = "\(history.type.title) '\(history.title)'"
      case .move:
        result = "\(history.type.title) '\(history.title)' from \(history.from ?? .todo) to \(history.to ?? .todo)"
      }
    }
    return result
  }
}
