//
//  Date+extension.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import Foundation

extension Date {
    var convertDateToString: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = .autoupdatingCurrent
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        let stringDate = dateFormatter.string(from: self)
        
        return stringDate
        
    }
}
