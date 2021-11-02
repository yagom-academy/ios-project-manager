//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

struct TodoViewModel: Identifiable {
    
    let todo: Todo
    
    let id = UUID()
    var title: String {
        return todo.title
    }
    var description: String {
        return todo.description
    }
    var dueDate: String {
        return todo.dueDate.description
    }
    var status: TodoStatus {
        return todo.status
    }
    
    func convertDateType2String(_ date: Date) -> String {
        let dateFommatter = DateFormatter()
        dateFommatter.locale = Locale(identifier: "ko_KR")
        dateFommatter.timeZone = TimeZone(abbreviation: "KST")
        dateFommatter.dateFormat = "yyyy. MM. dd."
        
        return dateFommatter.string(from: date)
    }
}
