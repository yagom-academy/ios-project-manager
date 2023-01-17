//
//  TaskEntityDummy.swift
//  ProjectManager
//
//  Created by 이정민 on 2023/01/17.
//

import Foundation

struct TaskEntityDummy {
    /// state
    /// case 1 = todo
    /// case 2 = doing
    /// case 3 = done

    static var dummys: [TaskEntity] = [
        TaskEntity(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1674140400, // 2023년
            state: 1
        ),
        
        TaskEntity(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1673881200,// 2023년
            state: 1
        ),
        
        TaskEntity(
            id: UUID().uuidString,
            title: "Mock Repository 만들기",
            content: "아얀이 열심히 만듦",
            deadLine: 1672498800, // 2023년
            state: 2
        ),
        
        TaskEntity(
            id: UUID().uuidString,
            title: "step2 PR",
            content: "coordinator까지 만들어서 보내기",
            deadLine: 1677596400, // 2023년
            state: 2
        ),
        
        TaskEntity(
            id: UUID().uuidString,
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1675436400, // 2023년
            state: 3
        )
    ]
}
