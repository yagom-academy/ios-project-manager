//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

protocol MemoViewModelInput {
    func add(_ memo: Memo)
    func delete(_ memo: Memo)
    func moveColumn(memo: Memo, to newState: MemoState)
    func modify(_ memo: Memo)
}

protocol MemoViewModelOutput {
    var memos: [[Memo]] { get }
}

final class MemoViewModel: ObservableObject, MemoViewModelOutput {
    @Published
    private(set) var model = MemoModel()
    
    var memos: [[Memo]] {
        return model.memos
    }
}

extension MemoViewModel: MemoViewModelInput {
    func add(_ memo: Memo) {
        model.add(memo)
    }
    
    func delete(_ memo: Memo) {
        model.delete(memo)
    }
    
    func moveColumn(memo: Memo, to newState: MemoState) {
        model.moveColumn(memo: memo, to: newState)
    }
    
    func modify(_ memo: Memo) {
        model.modify(memo)
    }
    
    
}
