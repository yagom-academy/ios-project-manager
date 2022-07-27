//
//  Date+.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

extension Date {
    func dateString() -> String {
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
    
    func historyString() -> String {
        Formatter.date.timeStyle = .medium
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
}
