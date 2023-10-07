//
//  MemoListViewModel.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/07.
//

import Foundation

final class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo]
    @Published var selectedMemo: Memo? = nil
    let memoManager: MemoManager
    let category: Memo.Category
    
    init(category: Memo.Category, memoManager: MemoManager) {
        self.category = category
        self.memoManager = memoManager
        memos = memoManager.filterMemo(by: category)
    }
    
    func deleteMemo(_ memo: Memo) {
        memoManager.deleteMemo(memo)
    }
    
    func update() {
        guard let selectedMemo = selectedMemo,
              let foundMemo = memoManager.findMemo(id: selectedMemo.id),
                  selectedMemo != foundMemo
        else { return }
        
        self.selectedMemo = foundMemo
    }
}
