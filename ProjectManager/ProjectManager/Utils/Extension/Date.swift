//
//  StringOptional.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.
//

import Foundation

extension Date {
  func nowDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY. MM. dd."
    return dateFormatter.string(from: self)
  }
}
