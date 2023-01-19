//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

protocol PlanManageable {
    func create(title: String, description: String, deadline: Date) -> Plan?
    func save(title: String, description: String, deadline: Date, plan: inout Plan?)
    func update(list: inout [Plan], id: UUID, status: Plan.Status)
    func update(planList: inout [Plan], plan: Plan)
    func fetch(id: UUID?) -> UUID?
    func delete(planList: inout [Plan], id: UUID?)
    func isValidContent(_ title: String?, _ description: String?) -> Bool
}
