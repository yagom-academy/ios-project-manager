//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

protocol MemoViewModelInput {
    func add(_ memo: Memo)
    func delete()
    func moveColumn()
    func modify()
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
    
    func delete() {
        
    }
    
    func moveColumn() {
        
    }
    
    func modify() {
        
    }
    
    
}
