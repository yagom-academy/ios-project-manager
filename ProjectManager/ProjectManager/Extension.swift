//
//  Extension.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import Foundation

// MARK: - DateFormatter
extension DateFormatter {
    func convertToUserLocaleString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        var locale = Locale.autoupdatingCurrent.identifier
        if let collatorLocale = Locale.autoupdatingCurrent.collatorIdentifier {
            locale = collatorLocale
        }
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: locale)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
