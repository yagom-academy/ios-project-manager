//
//  Double+.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/17.
//

import Foundation

extension Double {
    func convertDoubleToDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}
