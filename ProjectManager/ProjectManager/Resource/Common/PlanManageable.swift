//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

protocol PlanManageable {
    func create(title: String, description: String, deadline: Date) -> Plan?
    func update(title: String, description: String, deadline: Date, plan: inout Plan?)
    func update(id: UUID, status: Plan.Status)
    func fetch(id: UUID?) -> UUID?
    func delete(planList: inout [Plan], id: UUID?) 
}
