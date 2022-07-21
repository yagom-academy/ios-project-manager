//
//  CardHistoryViewModelItem.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import Foundation

struct CardHistoryViewModelItem {
  let card: Card
  let actionType: HistoryActionType
  let actionTimeString: String
  let informationString: String
}
