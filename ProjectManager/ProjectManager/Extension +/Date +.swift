//
//  Date +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import Foundation

extension Date {
    
    func changeDotFormatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter.string(from: self)
    }
    
    func isPast() -> Bool {
        let today = Date().changeDotFormatString()
        let date = self.changeDotFormatString()
        
        return today > date ? true : false
    }
    
    func changeHistoryDateFormatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, y h:m:s a"
        
        return dateFormatter.string(from: self)
    }
}
