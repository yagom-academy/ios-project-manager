//
//  Double+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

extension Double {

    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }

}
