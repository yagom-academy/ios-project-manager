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
            id: "1",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1674140400, // 2023년
            state: .toDo
        ),
        
        Task(
            id: "2",
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1673881200,
            state: .toDo
        ),
        
        Task(
            id: "3",
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1672498800,
            state: .toDo
        ),
        
        Task(
            id: "4",
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1677596400,
            state: .toDo
        ),
        
        Task(
            id: "5",
            title: "Mock Repository 만들기",
            content: "아얀이 열심히 만듦",
            deadLine: 1675436400,
            state: .doing
        ),
        
        Task(
            id: "6",
            title: "step2 PR",
            content: "coordinator까지 만들어서 보내기",
            deadLine: 1674140400,
            state: .doing
        ),
        
        Task(
            id: "7",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1674147600,
            state: .done
        )
    ]
}
