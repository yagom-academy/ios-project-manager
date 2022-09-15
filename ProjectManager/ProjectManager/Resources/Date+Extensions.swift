//
//  Date+extension.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

extension Date {
    func localizedFormat() -> String {
        let date = self

        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.autoupdatingCurrent
            dateFormatter.dateStyle = .long

            return dateFormatter
        }()
        
        return dateFormatter.string(from: date)
    }
}
