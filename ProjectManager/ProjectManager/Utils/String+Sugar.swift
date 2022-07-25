//
//  String+Sugar.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/21.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        return Formatter.date.date(from: self)
    }
}
