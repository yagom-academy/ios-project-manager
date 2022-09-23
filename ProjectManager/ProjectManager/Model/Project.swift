//
//  Project.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import Foundation

struct Project: Identifiable, Hashable {
    var id: UUID?
    var status: Status?
    var title: String?
    var detail: String?
    var date: Date?
    var placeholder = "내용을 입력하세요. (글자수는 1000자로 제한합니다)"
}

enum Status: String, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}
