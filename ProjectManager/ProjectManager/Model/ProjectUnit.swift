//
//  ProjectUnit.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import Foundation

struct ProjectUnit: Hashable {
    static let sample = ProjectUnit(
        id: UUID(),
        title: "쥬스 메이커",
        body: "쥬스 메이커 프로젝트입니다",
        section: "ToDo",
        deadLine: Date()
    )
    
    static let sample2 = ProjectUnit(
        id: UUID(),
        title: "은행 창구 매니저",
        body: "은행 창구 매니저 프로젝트입니다",
        section: "ToDo",
        deadLine: Date()
    )

    let id: UUID
    let title: String
    let body: String
    let section: String
    let deadLine: Date
}
