//
//  ToDoInfomation.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

struct ToDoInfomation: Identifiable {
    let id: UUID
    let title: String
    let discription: String
    let deadline: TimeInterval
    let state: ToDoPosition
}
