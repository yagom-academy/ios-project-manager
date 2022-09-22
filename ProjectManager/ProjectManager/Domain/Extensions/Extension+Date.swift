//
//  Extension+Date.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/22.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        
        return formatter.string(from: self)
    }
}
