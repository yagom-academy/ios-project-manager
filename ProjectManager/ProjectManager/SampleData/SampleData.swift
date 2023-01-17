//
//  SampleData.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/17.
//

import Foundation

struct SampleDummyData {
    let sampleDummy: [Task] = [
        Task(title: "첫번째업무", description: "첫업무입니다.", date: Date(), status: .todo),
        Task(title: "업무를 진행중입니다.", description: "진행중인 업무입니다.", date: Date(), status: .doing),
        Task(title: "이건 세번째업무고 끝냈습니다.", description: "끝난업무야", date: Date(), status: .done)
    ]
}
