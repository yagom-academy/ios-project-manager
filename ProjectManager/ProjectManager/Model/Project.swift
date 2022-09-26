//
//  Project.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import Foundation

struct Project {
    let uuid: UUID
    var status: Status = .todo
    let title: String
    let description: String
    let date: Date
}

extension Date {
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> Date {
        let date1 = Date.parse(string: start, format: format)
        let date2 = Date.parse(string: end, format: format)
        return Date.randomBetween(start: date1, end: date2)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    static func parse( string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}

// MARK: - Sample Data (for Test)

extension Project {
    static func generateSampleData(count: Int, maxBodyLine: Int, startDate: String, endData: String) -> [Project] {
        var initialTodoList: [Project] = []
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
            guard let randomStatus = Status(rawValue: Int.random(in: 0...2)),
                  let randomString = randomStringList.randomElement() else { break }
            let randomDate = Date.randomBetween(start: "2022-09-01", end: "2022-09-30")
            
            let todo = Project(uuid: UUID(),
                               status: randomStatus,
                               title: "\(index)번째 할 일",
                               description: "\(index)번째 : " + randomString,
                               date: randomDate)
            
            initialTodoList.append(todo)
        }
        
        return initialTodoList
    }
}
