//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import Foundation

extension Date {
  func changeToString() -> String {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy. MM. dd"
    dateFormatter.locale = Locale.current
    dateFormatter.timeZone = TimeZone.current

    return dateFormatter.string(from: self)
  }
}
