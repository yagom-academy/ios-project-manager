//
//  PostMemoModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation

struct PostMemoModel: Encodable {
    let title: String
    let content: String
    let dueDate: String
    let memoType: String
    
    private enum CodingKeys: String, CodingKey {
        case title, content
        case dueDate = "due_date"
        case memoType = "memo_type"
    }
}
