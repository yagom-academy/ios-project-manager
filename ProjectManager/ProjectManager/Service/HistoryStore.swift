//
//  HistoryStore.swift
//  ProjectManager
//
//  Created by song on 2022/07/28.
//

import Foundation

struct HistoryModel: Hashable {
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
}
