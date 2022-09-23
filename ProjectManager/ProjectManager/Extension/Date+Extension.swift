//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import Foundation

extension Date {
    func convertToRegion(timeStyle: DateFormatter.Style = .none) -> String {
        let localeLanguage = Locale.preferredLanguages.first ?? "ko"
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: localeLanguage)
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: self)
    }
}
