//
//  Extension+DateFormatter.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

extension TimeInterval {
    func dateFormatString(locale: Locale = Locale(identifier: "ko-KR")) -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.locale = locale
        dateFormmater.dateFormat = "yyyy. MM. dd."
        let convertedDate = Date(timeIntervalSince1970: self)
        return dateFormmater.string(from: convertedDate)
    }
}
