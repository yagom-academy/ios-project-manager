//
//  Date + extension.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/23.
//

import Foundation

extension Date {
    /// dateformatting to yyyy.mm.dd
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
