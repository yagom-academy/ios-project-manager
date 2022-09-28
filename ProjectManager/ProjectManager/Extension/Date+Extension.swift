//
//  String+Extension.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateStyle = .long
        formatterDate.timeStyle = .none
        formatterDate.locale = Locale.current
        
        return formatterDate.string(from: self)
    }
}
