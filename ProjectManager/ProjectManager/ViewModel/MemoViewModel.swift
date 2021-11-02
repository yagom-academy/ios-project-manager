//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

class MemoViewModel: ObservableObject {

    init() {
        (0...30).forEach { int in
            let randomRawValue = Int.random(in: 0..<Memo.State.allCases.count)
            let state = Memo.State(rawValue: randomRawValue)!
            let memo = Memo(
                id: UUID(),
                title: int.description,
                body: (int * 9999999999999).description,
                date: Date(),
                state: state
            )
            memoList[randomRawValue].append(memo)
        }
    }

    @Published var memoList: [[Memo]] = [[], [], []]

    func list(about state: Memo.State) -> [Memo] {
        return memoList[state.rawValue]
    }

    func delete(at index: Int, from state: Memo.State) {
        memoList[state.rawValue].remove(at: index)
    }
}
