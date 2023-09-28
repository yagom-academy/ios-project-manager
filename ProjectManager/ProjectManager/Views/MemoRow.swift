//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoRow: View {
    var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title)
                .font(.title3)
                .lineLimit(1)
            Text(memo.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            Text(memo.deadline.formatted(date: .numeric, time: .omitted))
        }
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(memo: ModelData().memos[0])
    }
}
