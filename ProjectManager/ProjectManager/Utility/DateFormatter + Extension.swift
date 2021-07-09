//
//  DateFormatter + Extension.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/07/07.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone.autoupdatingCurrent
    formatter.locale = Locale.current
    return formatter
  }()

    func customize(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, dateFormat: String) {
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.dateFormat = dateFormat
    }
}

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format)
    }

    func toStringUTC( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
