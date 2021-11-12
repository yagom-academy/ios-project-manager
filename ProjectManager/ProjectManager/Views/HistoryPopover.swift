//
//  HistoryPopover.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/13.
//

import SwiftUI

struct HistoryPopover: View {
    @EnvironmentObject var viewModel: MemoListViewModel
    
    var body: some View {
        VStack {
            HistoryRow()
            HistoryRow()
            HistoryRow()
            HistoryRow()
            HistoryRow()
        }
        .padding()
    }
}

struct HistoryPopover_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPopover()
    }
}
