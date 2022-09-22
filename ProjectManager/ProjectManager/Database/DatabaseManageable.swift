//
//  DatabaseManageable.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/22.
//

import Foundation

protocol DatabaseManageable {
    func saveWork(_ work: Work)
    func deleteWork(id: UUID)
    func fetchWork() -> [Work]
    func updateWork()
}
