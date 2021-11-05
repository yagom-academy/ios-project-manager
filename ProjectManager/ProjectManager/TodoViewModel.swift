//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/03.
//

import Foundation
import SwiftUI

final class TodoViewModel: ObservableObject {
    @Published var memoList: [Memo] = []
    
    func create(todo memo: Memo) {
        memoList.append(memo)
    }
    
    func delete(at index: Int) {
        if index < memoList.count {
            print("[TodoViewModel] Invalid delete index: \(index)")
            return
        }
        memoList.remove(at: index)
    }
    
    func delete(atOffsets indexSet: IndexSet) {
        memoList.remove(atOffsets: indexSet)
    }
    
    func update(at index: Int, todo memo: Memo) {
        if index >= memoList.count {
            print("[TodoViewModel] Invalid update index: \(index)")
            return
        }
        memoList[index] = memo
    }
    
    func classifyMemoList(state: TodoState) -> [Memo] {
        return memoList.filter { $0.state == state }
    }
    
    func countTodoCell(state: TodoState) -> Int {
        return memoList.filter {
            $0.state == state
        }.count
    }
    
    func changeDateColor(date: Date, state: TodoState) -> Color? {
        if state != TodoState.done && date < Date() {
            return Color.red
        }
        return Color.black
    }
}
