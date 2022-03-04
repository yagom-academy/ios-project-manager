//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

extension Date {

    var double: Double {
        Double(self.timeIntervalSince1970)
    }

}
