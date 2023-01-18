//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

protocol PlanManageable {
    func create(title: String, description: String, deadline: Date) -> Plan?
//    func update(planList: inout [Plan], plan: Plan)
    func update(id: UUID, status: Plan.Status)
    func fetch(id: UUID?) -> UUID?
    func fetchAllPlans() throws
    func delete(planList: inout [Plan], id: UUID) 
}
