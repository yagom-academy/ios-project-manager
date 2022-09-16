//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/16.
//

import Foundation

extension Date {
    func localizedDate() -> String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.autoupdatingCurrent
            dateFormatter.dateStyle = .long
            return dateFormatter
        }()
        
        return dateFormatter.string(from: self)
    }
}
