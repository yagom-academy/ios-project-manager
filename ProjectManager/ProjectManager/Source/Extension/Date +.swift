//
//  Date +.swift
//  ProjectManager
//  Created by inho on 2023/01/17.
//

import Foundation

extension Date {
    var convertedToString: String {
        return DateFormatter.listDateFormatter.string(from: self)
    }
}
