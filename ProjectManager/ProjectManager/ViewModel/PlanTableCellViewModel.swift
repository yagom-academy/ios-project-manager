//
//  PlanTableCellViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import Foundation
import Combine

final class PlanTableCellViewModel {
    @Published private(set) var plan: Plan
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    func convertDate(of date: Date) -> String {
        return DateFormatManager.shared.convertToFormattedDate(of: date)
    }
    
    func selectColor(_ date: Date) -> TextColor {
        let result = DateFormatManager.shared.compareDate(from: date)
        
        switch result {
        case .past:
            return .red
        default:
            return .black
        }
    }
    
    func fetchPlan() -> Plan {
        return plan
    }
}
