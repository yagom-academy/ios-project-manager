//
//  TodoHistory.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation

struct TodoHistory: Hashable {
    let id: String = UUID().uuidString
    let title: String
    let createdAt: Date
}
