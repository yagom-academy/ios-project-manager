//
//  Issue.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import Foundation

// TODO: Hashable 하므로 굳이 ID가 없어도 비교가 가능
struct Issue: Hashable {
    var id: UUID
    var status: Status
    var title: String
    var body: String
    var deadline: Date
}
