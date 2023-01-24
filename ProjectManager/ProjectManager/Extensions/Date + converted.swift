//
//  Date + converted.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

extension Date {
    func converted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMMdd")
        return dateFormatter.string(from: self)
    }
}
