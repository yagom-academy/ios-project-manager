//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

// Todo: - step2에서 Double타입의 경우에 해당하는 함수를 삭제하자 ====> 해결!!!
extension DateFormatter {
    func dateToString(date: Date) -> String {
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = "yyyy-MM-dd"
        
        return self.string(from: date)
    }
    
    func stringToDate(string: String) -> Date {
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = self.date(from: string)
        else {
            print("date에 이상한 String이 들어갔음..")
            return Date()
        }
        
        return date
    }
    
    func changeStringDateFormat(date: String) -> String {
        let date = stringToDate(string: date)
        
        return dateToString(date: date)
    }
}
