//
//  ProjectUnit.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import Foundation

struct ProjectUnit: Hashable {
    let id: UUID
    let title: String
    let body: String
    let section: String
    let deadLine: Date
}
