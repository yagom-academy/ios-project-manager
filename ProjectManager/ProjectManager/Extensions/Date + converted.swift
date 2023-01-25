//
//  Date + converted.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

extension Date {
    func converted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMMdd")
        return dateFormatter.string(from: self)
    }
    
    func expired() -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMMdd")
        let string = dateFormatter.string(from: self)
        let range = NSRange(location: 0, length: string.count)
        
        let mutableString = NSMutableAttributedString(string: string)
        mutableString.setAttributes([.foregroundColor: UIColor.systemRed], range: range)
        
        return mutableString
    }
}
