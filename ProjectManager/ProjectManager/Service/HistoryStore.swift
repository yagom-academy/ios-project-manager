//
//  HistoryStore.swift
//  ProjectManager
//
//  Created by song on 2022/07/28.
//

import Foundation
import SwiftUI

struct HistoryModel: Identifiable, Hashable {
  let id: UUID = UUID()
  var action: Action
  var title: String
  var originalStatus: Status?
  var nowStatus: Status?
  var data: Date
  
  init(action: Action = .create,
       title: String,
       originalStatus: Status? = nil,
       nowStatus: Status? = nil,
       data: Date) {
    self.action = action
    self.title = title
    self.originalStatus = originalStatus
    self.nowStatus = nowStatus
    self.data = data }
}

enum Action: String {
  case create = "Added"
  case move = "Moved"
  case delete = "Deleted"
  case edit = "Edited"
  
  var uiColor: Color {
    switch self {
    case .create:
      return Color("historyGreen")
//      return UIColor(red: 102, green: 255, blue: 178, alpha: 0.9)
    case .move:
      return Color("historyBlue")
//      return UIColor(red: 102, green: 178, blue: 255, alpha: 0.9)
    case .delete:
      return Color("historyRed")
//      return UIColor(red: 255, green: 102, blue: 102, alpha: 0.9)
    case .edit:
      return Color("histroyYellow")
//      return UIColor(red: 255, green: 255, blue: 102, alpha: 0.9)
    }
  }
}

