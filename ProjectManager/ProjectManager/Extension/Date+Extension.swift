//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import Foundation

extension Date {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
