//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

final class MemoListViewModel: ObservableObject {
    @Published private var currentState: ActionState = .read
    private(set) var memoList: [Memo.State: [Memo]] = [:]

    var memoToEdit: Memo? {
        guard case .update(let memo) = currentState else {
            return nil
        }

        return memo
    }

    // TODO: - Delete someday
    init() {
        Memo.State.allCases.forEach { state in
            memoList.updateValue([], forKey: state)
        }

        (0...30).forEach { int in
            let state = Memo.State.allCases.randomElement()!
            let memo = Memo(
                id: UUID(),
                title: int.description,
                body: (int * 9999999999999).description,
                date: Date(),
                state: state
            )

            memoList[state]?.append(memo)
        }
    }

    enum ActionState {
        case read
        case create
        case update(Memo)
        case delete
    }
}

// MARK: - CRUD
extension MemoListViewModel {
    func list(about state: Memo.State) -> [Memo] {
        return memoList[state] ?? []
    }

    func joinToCreateMemo() {
        currentState = .create
    }

    func joinToUpdate(_ memo: Memo) {
        currentState = .update(memo)
    }

    func edit(_ memo: Memo) {
        if case .create = currentState {
            insert(memo)
        } else if case .update(let updatingMemo) = currentState {
            update(from: updatingMemo, to: memo)
        } else {
            print("there is nothing to do")
        }
    }

    func afterEdit() {
        currentState = .read
    }

    func delete(at index: Int, from state: Memo.State) {
        currentState = .delete
        memoList[state]?.remove(at: index)
        currentState = .read
    }

    private func insert(_ memo: Memo) {
        if memo.isEmpty {
            return
        }

        memoList[.todo]?.insert(memo, at: .zero)
    }

    private func update(from old: Memo, to new: Memo) {
        let state = old.state

        if let target = memoList[state]?.firstIndex(of: old) {
            memoList[state]?[target].title = new.title
            memoList[state]?[target].body = new.body
            memoList[state]?[target].date = new.date
        }
    }
}
