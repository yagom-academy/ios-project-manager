//
//  DateFormatter+Extension.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/08.
//

import Foundation

extension DateFormatter {

    static let dueDate: DateFormatter = {
        let formatter = DateFormatter()
        let locale = Locale.preferredLanguages.first ?? Locale.current.identifier
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: locale)

        return formatter
    }()
}
