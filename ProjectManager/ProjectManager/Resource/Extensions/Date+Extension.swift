//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/16.
//

import Foundation

extension Date {
    var localizedString: String? {
        guard let localeID = Locale.preferredLanguages.first,
              let deviceLocale = Locale(identifier: localeID).languageCode else {
            return nil
        }

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: deviceLocale)
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter.string(from: self)
    }
}
