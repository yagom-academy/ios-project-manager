//
//  HistoryPopover.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/13.
//

import SwiftUI

struct HistoryPopover: View {
    @ObservedObject var historyListViewModel: HistoryListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(historyListViewModel.historyViewModels, id: \.id) { history in
                    HistoryRow(history: history)
                }
            }
            .padding()
        }
    }
}

struct HistoryPopover_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPopover(historyListViewModel: HistoryListViewModel())
    }
}
