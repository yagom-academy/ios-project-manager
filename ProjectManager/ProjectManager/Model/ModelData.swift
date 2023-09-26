//
//  ModelData.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import Foundation

var testMemo: [Memo] = [
    Memo(title: "title1", body: "body1", deadline: "2023. 09. 23.", category: .toDo),
    Memo(title: "title2", body: "body2", deadline: "2023. 09. 24.", category: .toDo),
    Memo(title: "title3", body: "body3", deadline: "2023. 09. 25.", category: .doing),
    Memo(title: "title4", body: "body4", deadline: "2023. 09. 26.", category: .done),
    Memo(title: "title5", body: "body5", deadline: "2023. 09. 27.", category: .done)
]

final class ModelData: ObservableObject {
    @Published var memos: [Memo] = testMemo
    
    var categories: [Int: [Memo]] {
        Dictionary(
            grouping: memos,
            by: { $0.category.rawValue }
        )
    }
}
