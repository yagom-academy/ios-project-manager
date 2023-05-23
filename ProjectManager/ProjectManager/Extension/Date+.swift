//
//  ProjectManager - Date+.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy. MM. dd."
        let text = dateFormatter.string(from: self)
        
        return text
    }
}
