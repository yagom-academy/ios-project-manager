//
//  Date+.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

extension Date {
    func convertToString() -> String {
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
    
    func convertToHistoryString() -> String {
        Formatter.date.timeStyle = .medium
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
    
    func convertToString(isMarkTheTime: Bool = false) -> String {
        Formatter.date.timeStyle = isMarkTheTime == false ? .none : .medium
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
}
