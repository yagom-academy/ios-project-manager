//
//  Extension+String.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/22.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}
