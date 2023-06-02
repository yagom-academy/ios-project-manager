//
//  PlanCellViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation
import Combine

final class PlanCellViewModel {
    @Published var title: String
    @Published var body: String
    @Published var date: String
    @Published var isDateExpired: Bool?
    
    init(plan: Plan, dateFormatter: DateFormatter) {
        title = plan.title
        body = plan.body
        date = dateFormatter.string(from: plan.date)
        if plan.workState != .done {
            isDateExpired = validateDate(with: dateFormatter)
        }
    }
    
    private func validateDate(with dateFormatter: DateFormatter) -> Bool? {
        let todayString = dateFormatter.string(from: Date())
        guard let today = dateFormatter.date(from: todayString),
              let planDate = dateFormatter.date(from: self.date) else {
            return nil
        }
        
        let result = today.compare(planDate)
        
        return (result == .orderedDescending) ? true : false
    }
}
