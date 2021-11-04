//
//  MemoModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

struct MemoModel {
    private(set) var memos: [[Memo]] = [[],[],[]]
    
    mutating func add(_ memo: Memo) {
        memos[memo.status.indexValue].append(memo)
    }
    
    mutating func delete(column: MemoState, indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        memos[column.indexValue].remove(at: index)
    }
}
