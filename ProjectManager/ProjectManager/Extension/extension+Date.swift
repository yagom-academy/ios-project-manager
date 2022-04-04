//
//  extension+Date.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/21.
//

import Foundation

extension Date {
    func isLastDay() -> Bool {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        if self > startOfDay {
            return true
        } else {
            return false
        }
    }
}
