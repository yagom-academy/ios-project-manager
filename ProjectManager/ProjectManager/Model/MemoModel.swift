//
//  MemoModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

struct MemoModel {
    private(set) var memos: [[Memo]] = [[],[],[]]

    private func find(_ memo: Memo) -> Int? {
        let specificStateMemoList = memos[memo.status.indexValue]
        for index in specificStateMemoList.indices {
            if specificStateMemoList[index].id == memo.id {
                return index
            }
        }
        return nil
    }
    
    mutating func add(_ memo: Memo) {
        memos[memo.status.indexValue].append(memo)
    }
    
    @discardableResult
    mutating func delete(_ memo: Memo) -> Memo? {
        guard let index = find(memo) else {
            return nil
        }
        return memos[memo.status.indexValue].remove(at: index)
    }
    
    mutating func moveColumn(memo: Memo, to newState: MemoState) {
        guard var memo = delete(memo) else {
            return
        }
        memo.status = newState
        add(memo)
    }
    
    mutating func modify(_ memo: Memo) {
        guard let index = find(memo) else {
            return
        }
        memos[memo.status.indexValue][index].title = memo.title
        memos[memo.status.indexValue][index].date = memo.date
        memos[memo.status.indexValue][index].description = memo.description
    }
}
