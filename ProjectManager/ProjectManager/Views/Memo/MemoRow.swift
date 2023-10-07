//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoRow: View {
    private var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
    
    var isOverdue: Bool {
        if (memo.category == .toDo || memo.category == .doing) && (Calendar.current.compare(memo.deadline, to: .now, toGranularity: .day) == .orderedAscending) {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title)
                .font(.title3)
                .lineLimit(1)
            
            Text(memo.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Text(memo.deadline.formatted(date: .numeric, time: .omitted))
                .foregroundColor(isOverdue ? .red : .primary)
        }
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(memo: ModelData().memos[0])
    }
}
