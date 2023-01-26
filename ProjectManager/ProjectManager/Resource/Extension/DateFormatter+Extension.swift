//  ProjectManager - DateFormatter+Extension.swift
//  created by zhilly on 2023/01/19

import Foundation

extension DateFormatter {
    static func convertToString(to date: Date, style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        
        return dateFormatter.string(from: date)
    }
    
    static func convertToFullString(to date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
}
