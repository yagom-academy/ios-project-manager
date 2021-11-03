//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

protocol AlertControllerable {
    func show(with: Error)
}

class MemoViewModel: ObservableObject {
    var alertController: AlertControllerable?

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

    @Published private var memoList: [[Memo]] = [[], [], []]

    private var isCreatingMemo = false
    private var updatimgMemo: Memo?

    func list(about state: Memo.State) -> [Memo] {
        return memoList[state.rawValue]
    }

    func delete(at index: Int, from state: Memo.State) {
        memoList[state.rawValue].remove(at: index)
    }

    func createMemo() {
        isCreatingMemo = true
    }

    func update(_ memo: Memo) {
        updatimgMemo = memo
    }

    func edit(_ memo: Memo) {
        if isCreatingMemo {
            insert(memo)
        } else if let updatimgMemo = updatimgMemo {
            update(from: updatimgMemo, to: memo)
        } else {
            print("there is nothing to do")
        }
    }

    func afterEdit() {
        isCreatingMemo = false
        updatimgMemo = nil
    }

    private func insert(_ memo: Memo) {
        if memo.isEmpty {
            return
        }

        let todo = Memo.State.todo.rawValue
        memoList[todo].insert(memo, at: .zero)
    }

    private func update(from old: Memo, to new: Memo) {
        let state = old.state.rawValue
        if let target = memoList[state].firstIndex(of: old) {
            memoList[state][target].title = new.title
            memoList[state][target].body = new.body
            memoList[state][target].date = new.date
            memoList[state][target].state = new.state
        }
    }

    enum ThisError: Error {
        case stateError
    }
}
