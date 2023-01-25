//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

protocol PlanManageable {
    func create(title: String, description: String, deadline: Date) -> Plan
    func update(plan: Plan)
    func update(id: UUID, status: Plan.Status)
    func isExistID(id: UUID?) -> Bool
    func delete(id: UUID?)
}
