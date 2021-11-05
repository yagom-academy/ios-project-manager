//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

final class MemoViewModel: ObservableObject {
    @Published private var currentState: ActionState = .read
    private(set) var memoList: [[Memo]] = .init(repeating: [], count: Memo.State.allCases.count)

    // TODO: - Delete someday
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

    enum OpaqueError: Error {
        case stateError
    }

    enum ActionState {
        case read
        case create
        case update(Memo)
        case delete
    }
}

// MARK: - CRUD
extension MemoViewModel {
    func list(about state: Memo.State) -> [Memo] {
        return memoList[state.rawValue]
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

    func memoToEdit() -> Memo? {
        guard case .update(let memo) = currentState else {
            return nil
        }

        return memo
    }

    func delete(at index: Int, from state: Memo.State) {
        currentState = .delete
        memoList[state.rawValue].remove(at: index)
        currentState = .read
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
        }
    }
}
