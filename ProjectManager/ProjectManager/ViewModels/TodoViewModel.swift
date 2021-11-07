//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

struct TodoViewModel: Identifiable {
    let todo: Todo
    
    let id = UUID().uuidString
    var title: String {
        return todo.title
    }
    var description: String {
        return todo.description
    }
    var dueDate: Date {
        return todo.dueDate
    }
    var dueDateFormatted: String {
        return convertDateType2String(todo.dueDate)
    }
    var status: TodoStatus {
        return todo.status
    }
    
    var isExpired: Bool {
        let currentTime = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        let today = Date().timeIntervalSince(currentTime)
        let dueDay = Date().timeIntervalSince(todo.dueDate)
        
        return today < dueDay
    }
    
    private func convertDateType2String(_ date: Date) -> String {
        let dateFommatter = DateFormatter()
        dateFommatter.locale = Locale(identifier: "ko_KR")
        dateFommatter.timeZone = TimeZone(abbreviation: "KST")
        dateFommatter.dateFormat = "yyyy. M. d."
        
        return dateFommatter.string(from: date)
    }
}
