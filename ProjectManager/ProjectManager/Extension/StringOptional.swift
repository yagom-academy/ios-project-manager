//
//  StringOptional.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.
//

import Foundation

extension Optional where Wrapped == String {
  static func nowDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY. MM. dd."
    return dateFormatter.string(from: date)
  }
}
