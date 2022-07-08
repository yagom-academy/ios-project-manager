//
//  Date + Extension.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/08.
//

import Foundation

extension Date {
    var dateToString: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = .autoupdatingCurrent
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy. M. d."
        
        let stringDate = dateFormatter.string(from: self)
        
        return stringDate
    }
}
