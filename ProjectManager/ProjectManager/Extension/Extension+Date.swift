//
//  Extension+Date.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/14.
//

import Foundation

extension Date {
    func dateString( format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
