//
//  PlanTableCellViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import UIKit
import Combine

final class PlanTableCellViewModel {
    @Published private(set) var plan: Plan
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    func convertDate(of date: Date) -> String {
        return DateFormatManager.shared.convertToFormattedDate(of: date)
    }
    
    func selectColor(_ date: Date) -> UIColor {
        let result = DateFormatManager.shared.compareDate(from: date)
        
        switch result {
        case .past:
            return UIColor.red
        default:
            return UIColor.black
        }
    }
    
    func fetchPlan() -> Plan {
        return plan
    }
}
