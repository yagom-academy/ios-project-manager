//
//  TaskDummy.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

struct TaskDummy {
    static var dummys: [Task] = [
        Task(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: "Jan 20, 2023",
            state: .toDo,
            isExpired: true
        ),
        
        Task(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: "Jan 10, 2023",
            state: .toDo,
            isExpired: false
        ),
        
        Task(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: "Sep 9, 2023",
            state: .toDo,
            isExpired: true
        ),
        
        Task(
            id: UUID().uuidString,
            title: "Mock Repository 만들기",
            content: "아얀이 열심히 만듦",
            deadLine: "Jan 20, 2023",
            state: .doing,
            isExpired: true
        ),
        
        Task(
            id: UUID().uuidString,
            title: "step2 PR",
            content: "coordinator까지 만들어서 보내기",
            deadLine: "Jan 18, 2023",
            state: .doing,
            isExpired: true
        ),
        
        Task(
            id: UUID().uuidString,
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: "Jan 10, 2023",
            state: .done,
            isExpired: false
        )
    ]
}
