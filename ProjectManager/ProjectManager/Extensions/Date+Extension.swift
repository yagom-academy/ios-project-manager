//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by jin on 1/26/23.
//

import Foundation

extension Date {
    var customDateDescription: String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy. M. d."
                
        return dateFormatter.string(from: self)
    }
}
