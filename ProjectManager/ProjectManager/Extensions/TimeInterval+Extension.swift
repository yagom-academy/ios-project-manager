//
//  TimeInterval+Extension.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/10.
//

import Foundation

extension TimeInterval {
    func translateToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone.current
        let date = Date(timeIntervalSince1970: self)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
