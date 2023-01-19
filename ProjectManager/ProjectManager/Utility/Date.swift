//
//  Date.swift
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
