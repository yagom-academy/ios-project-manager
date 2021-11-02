//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

class MemoViewModel: ObservableObject {
    var memoList = [Memo]() {
        didSet {
            todoList = memoList.filter({ memo in
                memo.state == .todo
            })
            doingList = memoList.filter({ memo in
                memo.state == .doing
            })
            doneList = memoList.filter({ memo in
                memo.state == .done
            })
        }
    }

    var todoList = [Memo]()
    var doingList = [Memo]()
    var doneList = [Memo]()

    func focus(memo: Memo?) {
        
    }
}
