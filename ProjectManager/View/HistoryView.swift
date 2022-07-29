//
//  HistoryView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/27.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject private(set) var historyViewModel: HistoryViewModel
  
    var body: some View {
      List {
        ForEach(historyViewModel.allHistories) { history in
          VStack(alignment: .leading) {
            Text(historyViewModel.showHistory(history))
            Text(historyViewModel.showDate(history))
              .foregroundColor(.gray)
          }
        }
      }
      .frame(width: 500, height: 300)
      .listStyle(.grouped)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
      HistoryView(historyViewModel: HistoryViewModel(withService: TaskManagementService()))
    }
}
