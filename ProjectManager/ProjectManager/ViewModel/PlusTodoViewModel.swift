//
//  PlusTodoViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import Foundation
import Combine

final class PlusTodoViewModel {
    private(set) var currentPlan: Plan?
    private(set) var isEdit: Bool?

    func addPlan(_ plan: Plan) {
        currentPlan = plan
    }
    
    func configureInitialPlan(title: String, body: String, date: Date) -> Plan {
        let item = Plan(title: title, body: body, date: date, state: .todo)
        return item
    }
    
    func updateCurrentPlan(title: String, body: String, date: Date) -> Plan? {
        guard var plan = currentPlan else { return nil }
       
        if isEdit == true {
            plan.title = title
            plan.body = body
            plan.date = date
        }
        return plan
    }
    
    func fetchCurrentPlan() -> Plan? {
        guard let plan = currentPlan else { return nil }
        return plan
    }
    
    func changEditMode() {
        isEdit = true
    }
}
