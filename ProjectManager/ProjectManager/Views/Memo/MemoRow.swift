//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoRow: View {
    @ObservedObject var viewModel: MemoRowViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.memo.title)
                .font(.title3)
                .lineLimit(1)
            
            Text(viewModel.memo.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Text(viewModel.memo.deadline.formatted(date: .numeric, time: .omitted))
                .foregroundColor(viewModel.isOverdue ? .red : .primary)
        }
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(viewModel: MemoRowViewModel(memo: MemoManager().memos[0]))
    }
}
