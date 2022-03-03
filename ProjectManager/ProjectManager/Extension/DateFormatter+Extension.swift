//
//  DateFormatter+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import Foundation

extension DateFormatter {

    static let todoDate: DateFormatter = {
        let formatter = DateFormatter()
        let locale = Locale.preferredLanguages.first ?? Locale.current.identifier
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: locale)

        return formatter
    }()
}
