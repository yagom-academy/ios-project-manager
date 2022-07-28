//
//  StringOptional.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.
//

import Foundation

extension Date {
  static func nowDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY. MM. dd."
    return dateFormatter.string(from: date)
  }
  
  static func makeDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
  }
}
