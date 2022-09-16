//
//  DateManager.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/14.
//

import Foundation

struct DateManager {
    func checkOverdue(date: Date) -> Bool {
        let today = Date().convertToRegion()
        let dateToCompare = date.convertToRegion()
        
        return today != dateToCompare && Date() >= date
    }
}
