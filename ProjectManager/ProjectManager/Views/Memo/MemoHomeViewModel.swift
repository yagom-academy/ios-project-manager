//
//  MemoHomeViewModel.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/07.
//

import Foundation

final class MemoHomeViewModel: ObservableObject {
    @Published var showDetail: Bool = false
    let memoManager: MemoManager
    let categories = Memo.Category.allCases
    
    var newMemo: Memo {
        memoManager.newMemo
    }
    
    init(memoManager: MemoManager) {
        self.memoManager = memoManager
    }
}
