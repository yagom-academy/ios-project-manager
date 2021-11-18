//
//  DateFormatter+Extension.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import Foundation

extension DateFormatter {
    static func format(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.M.d"
        
        return dateFormatter.string(from: date)
    }
}
