//
//  Int.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import Foundation

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
  
  static func <<(lhs: Int, rhs: Int) -> Bool {
    let calendar = Calendar.current
    
    let lhs = lhs.convertedDate
    let rhs = rhs.convertedDate
    
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: lhs, to: rhs)
    
    guard let year = dateComponents.year,
          year >= 0 else {
      return false
    }
    
    guard let month = dateComponents.month,
          month >= 0 else {
      return false
    }
    
    guard let day = dateComponents.day,
          day >= 0 else {
      return false
    }
    
    return true
  }
}
