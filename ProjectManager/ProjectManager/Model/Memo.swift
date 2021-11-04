//
//  Memo.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import Foundation

let dummyMemos: [Memo] = [
    Memo(title: "제목 1", description: "asdf", date: "asdf"),
    Memo(title: "제목 2", description: "asdf", date: "asdf", status: .doing),
    Memo(title: "제목 3", description: "asdf", date: "asdf", status: .done)
]

enum MemoState {
    case toDo
    case doing
    case done
}

struct Memo: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var date: String
    var status: MemoState = .toDo
}


