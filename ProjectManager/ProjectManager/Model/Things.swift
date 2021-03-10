//
//  Things.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import Foundation

struct Things {
    var todoList: [Thing] = [
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 121212)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용", date: Date(timeIntervalSinceNow: -1231234545)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 145)),
        Thing(title: "제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -145)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: 1234512345)),
    ]
    var doingList: [Thing] = [
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -1245)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -1235)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 123)),
        Thing(title: "제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -12)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 5)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 12345)),
        Thing(title: "제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: 345)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
    ]
    var doneList: [Thing] = [
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 2345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -1345)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 2345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 2345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -1345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 12345)),
        Thing(title: "제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -123)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: 2345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -45)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -123)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
        Thing(title: "제목", body: "내용", date: Date(timeIntervalSinceNow: -12345)),
    ]
    static var shared: Things = Things()
    private init () {}
}
