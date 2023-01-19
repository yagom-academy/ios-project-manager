//
//  Int.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import Foundation

extension Date {
  static let dateFormatter = DateFormatter()
  
  func convertDate() -> Date {
    let calendar = Calendar.current
    return calendar.startOfDay(for: self)
  }
}

extension Int {
  var convertedDateDescription: String {
    let formatter = Date.dateFormatter
    
    formatter.dateFormat = "yyyy. MM. dd."
    let date = Date(timeIntervalSince1970: Double(self))
    return formatter.string(from: date)
  }
  
  var convertedDate: Date {
    return Date(timeIntervalSince1970: TimeInterval(self))
  }
}
