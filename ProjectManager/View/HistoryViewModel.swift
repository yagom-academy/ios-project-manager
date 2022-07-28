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
  
  override init(withService: TaskManagementService) {
    super.init(withService: withService)
    self.allHistories = withService.allHistories
  }
  
  func showHistory(_ history: History) -> String {
    var result: String = ""
    
    switch history.type {
    case .add:
      result = "\(history.type.title) '\(history.title)'."
    case .move:
      result = "\(history.type.title) '\(history.title)' from \(history.from?.title ?? "") to \(history.to?.title ?? "")."
    case .remove:
      result = "\(history.type.title) '\(history.title)' from \(history.from?.title ?? "")."
    }
    return result
  }
  
  func showDate(_ history: History) -> String {
    let currentDate = Date().convertTimeToString
    return currentDate
  }
}
