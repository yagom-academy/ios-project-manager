//
//  Date.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import Foundation

extension Date {
    var localizedString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.locale = .current

        return dateFormater.string(from: self)
    }
}
