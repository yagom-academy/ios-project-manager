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
      VStack(alignment: .leading) {
        HStack {
          Text(history.action.rawValue)
            .padding(.horizontal)
            .background(history.action.uiColor)
            .foregroundColor(.white)
            .cornerRadius(4)
          Text("'\(history.title)'")
          
          if history.action == .delete {
            Text("from \(history.originalStatus?.rawValue ?? "")")
          }
          
          if history.action == .move {
            Text("from \(history.originalStatus?.rawValue ?? "")")
            Text("to \(history.nowStatus?.rawValue ?? "")")
          }
        }
        Text(history.data.toString())
      }
    }
    .frame(width: 500, height: 300)
    .listStyle(.automatic)
  }
}
