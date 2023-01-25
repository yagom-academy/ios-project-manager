//
//  Date.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import Foundation

extension Date {
  static let onlyDateFormat = FormatStyle.dateTime.year().month().day()
  
  func onlyDate() -> String {
    return self.formatted(Self.onlyDateFormat)
  }
}
