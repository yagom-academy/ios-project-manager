//
//  DateFommater.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

extension DateFormatter {
    func localizedDateString(from timeInterval: TimeInterval) -> String {
        let convertedDate = Date(timeIntervalSince1970: timeInterval)
        self.dateFormat = "yyyy. MM. dd."
        self.locale = Locale.current
        return self.string(from: convertedDate)
    }
}
