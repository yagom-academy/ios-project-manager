//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

protocol MemoViewModelInput {
    func add()
    func delete()
    func moveColumn()
    func modify()
}

protocol MemoViewModelOutput {
    var memos: [[Memo]] { get }
}

final class MemoViewModel: ObservableObject {
    @Published
    private(set) var model = MemoModel()
}
