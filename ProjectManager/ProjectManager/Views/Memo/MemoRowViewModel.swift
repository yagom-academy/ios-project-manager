//
//  MemoRowViewModel.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/09.
//

import Foundation

final class MemoRowViewModel: ObservableObject {
    @Published var memo: Memo
    
    var isOverdue: Bool {
        if (memo.category == .toDo || memo.category == .doing) && (Calendar.current.compare(memo.deadline, to: .now, toGranularity: .day) == .orderedAscending) {
            return true
        }
        return false
    }

    init(memo: Memo) {
        self.memo = memo
    }
}
