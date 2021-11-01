//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/29.
//

import Foundation

extension Date {
    
    func format(locale: Locale = Locale(identifier: "ko_KR")) -> String {
        let date = DateFormatter()
        
        date.locale = locale
        date.dateFormat = "yyyy. MM. dd"
        return date.string(from: self)
    }
}
