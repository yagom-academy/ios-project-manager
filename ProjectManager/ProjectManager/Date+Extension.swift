//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/05.
//

import Foundation

extension Date {
    var formatted: String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. MM. d"
            return dateFormatter
        }()
        
        return dateFormatter.string(from: self)
    }
    
    var isExpired: Bool {
        return self.timeIntervalSince1970 < Date().timeIntervalSince1970
    }
}
