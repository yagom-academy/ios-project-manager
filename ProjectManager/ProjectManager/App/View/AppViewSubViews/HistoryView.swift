//
//  HistoryView.swift
//  ProjectManager
//
//  Created by song on 2022/07/28.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject var viewModel: HistoryViewModel
  
  init(viewModel: HistoryViewModel) {
    self.viewModel = viewModel
  }
  
  
  var body: some View {
    List(viewModel.todoService.historyStore, id: \.self) { history in
      VStack {
        HStack{
          Text(history.action.rawValue)
          Text(history.title)
          Text(history.originalStatus?.rawValue ?? "")
          Text(history.nowStatus?.rawValue ?? "")
        }
        Text(history.data.toString())
      }
    }
  }
}
