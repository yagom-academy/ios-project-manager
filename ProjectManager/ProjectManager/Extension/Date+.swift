//
//  Date+.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/26.
//

import Foundation

extension Date {
    static var today: Date {
        let date: Date = Date()
        return date
    }
    
    
    
    func converString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        return dateFormatter.string(from: date)
    }
    
    func compareToday(with date: Date) -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let deadlineString = dateFormatter.string(from: date)
        let currentDateString = dateFormatter.string(from: currentDate)
        
        print(deadlineString)
        print(currentDateString)
        
        guard let deadline = dateFormatter.date(from: deadlineString),
              let today = dateFormatter.date(from: currentDateString) else {
            return false
        }
        //true일 때 빨간색
        switch today.compare(deadline) {
        case .orderedSame:
            print("같음")
            return true
        case .orderedAscending:
            print("큼")
            return false
        case .orderedDescending:
            print("작음")
            return true
        }
        
    }
    
    
}
