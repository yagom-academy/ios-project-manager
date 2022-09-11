//
//  DBManagerable.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

protocol DBManagerable {
    func fetch() -> [Todo]
    func add(title: String, body: String, status: Status)
    func delete(id: UUID)
    func update(id: UUID, title: String, body: String)
    func changeStatus(id: UUID, to status: Status)
}
