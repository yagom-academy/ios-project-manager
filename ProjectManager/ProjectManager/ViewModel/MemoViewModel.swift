//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/08.
//

import Foundation

struct MemoViewModel {
    private let characterLimit = 1000
    private(set) var memo: Memo
    var memoTitle: String {
        set {
            memo.title = newValue
        }
        get {
            return memo.title
        }
    }
    var memoDescription: String {
        set {
            if newValue.count <= characterLimit {
                memo.description = newValue
            }
        }
        get {
            return memo.description
        }
    }
    var memoDate: Date {
        set {
            memo.date = newValue
        }
        get {
            return memo.date
        }
    }
    var memoId: UUID {
        return memo.id
    }
    var memoStatus: MemoState {
        set {
            memo.status = newValue
        }
        get {
            return memo.status
        }
    }
    
    init(memo: Memo = Memo()) {
        self.memo = memo
    }
    
    func isPastDeadline() -> Bool {
        let today = Date()
        let calendar = Calendar.current
        if calendar.compare(today, to: memoDate, toGranularity: .day) == .orderedDescending {
            return true
        }
        return false
    }
    
    func filterOutState() -> [MemoState] {
        var states = MemoState.allCases
        states.remove(at: memoStatus.indexValue)
        return states
    }
}
