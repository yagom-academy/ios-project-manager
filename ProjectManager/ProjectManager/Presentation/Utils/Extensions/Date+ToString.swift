//
//  Date+ToString.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation

extension Date {
    func toString(_ dateFormatter: DateFormatter?) -> String? {
        return dateFormatter?.string(from: self)
    }
}
