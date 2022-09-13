//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/13.
//

import Foundation

extension Date {
    func convertLocalization() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
    
        return dateFormatter.string(from: self)
    }
}
