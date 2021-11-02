//
//  Memo.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import Foundation

struct Memo: Identifiable {
    enum State {
        case todo
        case doing
        case done
    }
    var id = UUID()
    var title: String
    var description: String
    var date: Date
    var state: State
}
extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
