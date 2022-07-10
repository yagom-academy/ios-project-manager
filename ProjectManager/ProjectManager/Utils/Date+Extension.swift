//
//  Date+.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

extension Date {
    func convertToString() -> String? {
        return CurrentDateFormatter.dateFormatter.string(for: Self.self)
    }
}
