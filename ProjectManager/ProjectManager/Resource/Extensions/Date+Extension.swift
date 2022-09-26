//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/16.
//

import Foundation

extension Date {
    var localizedString: String? {
        return DateFormatterManager.shared.convertToDateString(from: self)
    }
}
