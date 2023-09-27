//
//  ModelData.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import Foundation

var testMemo: [Memo] = [
    Memo(title: "title1", body: "body1", deadline: .now, category: .toDo),
    Memo(title: "title2", body: "body2", deadline: .now, category: .toDo),
    Memo(title: "title3", body: "body3", deadline: .now, category: .doing),
    Memo(title: "title4", body: "body4", deadline: .now, category: .done),
    Memo(title: "title5", body: "body5", deadline: .now, category: .done),
    Memo(title: "title6", body: "body6", deadline: .now, category: .toDo)
]

final class ModelData: ObservableObject {
    @Published var memos: [Memo] = testMemo
    
    var toDoList: [Memo] {
        memos.filter { $0.category == .toDo }
    }
    
    var doingList: [Memo] {
        memos.filter { $0.category == .doing }
    }
    
    var doneList: [Memo] {
        memos.filter { $0.category == .done }
    }
}
