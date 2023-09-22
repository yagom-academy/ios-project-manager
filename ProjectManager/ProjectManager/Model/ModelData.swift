//
//  ModelData.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import Foundation

var testMemo: [Memo] = [
    Memo(title: "title1", body: "body1", deadline: "2023. 09. 23."),
    Memo(title: "title2", body: "body2", deadline: "2023. 09. 24."),
    Memo(title: "title3", body: "body3", deadline: "2023. 09. 25."),
    Memo(title: "title4", body: "body4", deadline: "2023. 09. 26."),
    Memo(title: "title5", body: "body5", deadline: "2023. 09. 27.")
]

final class ModelData: ObservableObject {
    var toDoList = MemoList(memos: testMemo, category: .toDo)
    var doingList = MemoList(memos: testMemo, category: .doing)
    var doneList = MemoList(memos: testMemo, category: .done)
}
