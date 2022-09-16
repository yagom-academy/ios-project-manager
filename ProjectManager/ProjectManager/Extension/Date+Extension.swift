//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import Foundation

extension Date {
    func convertToRegion() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
