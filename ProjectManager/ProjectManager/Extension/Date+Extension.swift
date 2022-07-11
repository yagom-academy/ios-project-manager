//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

extension Date {
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy. M. d."
    dateFormatter.locale = Locale.current
    
    return dateFormatter.string(from: self)
  }
}
