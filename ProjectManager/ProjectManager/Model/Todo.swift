//
//  Todo.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import Foundation

struct Todo {
    var title: String
    var body: String
    var createdAt: Date
    var status: TodoStatus
    var isOutdated: Bool
}

// MARK: - Sample Data (for Test)

extension Todo {
    static func generateSampleData(count: Int, maxBodyLine: Int, startDate: String, endData: String) -> [Todo] {
        var initialTodoList: [Todo] = []
        var randomStringList: [String] = []
        
        for index in (0..<maxBodyLine) {
            guard !randomStringList.isEmpty else {
                randomStringList.append("\(index)번째 줄")
                continue
            }
            
            let mergedString = randomStringList[index - 1] + "\n\(index)번째 줄"
            randomStringList.append(mergedString)
        }
        
        for index in (0..<count) {
            guard let randomStatus = TodoStatus(rawValue: Int.random(in: 0...2)),
                  let randomString = randomStringList.randomElement() else { break }
            let randomDate = Date.randomBetween(start: "2022-09-01", end: "2022-09-30")
            
            let todo = Todo(title: "\(index)번째 할 일", body: "\(index)번째 : " + randomString, createdAt: randomDate, status: randomStatus, isOutdated: false)
            
            initialTodoList.append(todo)
        }
        
        return initialTodoList
    }
}
