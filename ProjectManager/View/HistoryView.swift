//
//  HistoryView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/27.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject var historyViewModel: HistoryViewModel
  
    var body: some View {
      List {
        VStack(alignment: .leading) {
          Text(historyViewModel.showHistory())
          Text("Mar 11, 2020 3:32:07 PM")
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
