//
//  Formatter.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import Foundation

enum Formatter {
  private static let dateFormatter = DateFormatter()

  static func changeToString(from date: Date) -> String {
    dateFormatter.dateFormat = "yyyy. MM. dd"
    dateFormatter.locale = Locale.current
    dateFormatter.timeZone = TimeZone.current

    return dateFormatter.string(from: date)
  }
}
