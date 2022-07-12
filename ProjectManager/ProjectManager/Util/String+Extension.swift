//
//  String+Extension.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import Foundation

extension String {
  func dateCompare(from date: Date) -> ComparisonResult {
    let currentDate = Formatter.changeToString(from: date)
    let result = self.compare(currentDate)
    
    return result
  }
}
