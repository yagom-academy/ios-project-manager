//
//  DateFormatter+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/04.
//

import Foundation

extension DateFormatter {

    static let deadlineFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        let locale = Locale.preferredLanguages.first ?? Locale.current.identifier
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: locale)

        return dateFormatter
    }()
}
