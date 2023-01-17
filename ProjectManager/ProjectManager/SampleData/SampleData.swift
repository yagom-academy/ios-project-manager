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
        Task(title: "업무를 진행중입니다.", description: "진행중인 업무입니다.", date: Date(), status: .todo),
        Task(title: "이건이거쎌.", description: "끝난업무야", date: Date(), status: .done),
        Task(title: "굿ios다.", description: "진행중인 업무입니다.", date: Date(), status: .done),
        Task(title: "이거예시니다.", description: "끝난업무야", date: Date(), status: .done),
        Task(title: "업되나진행중입니다.", description: "진행중인 업무입니다.", date: Date(), status: .todo),
        Task(title: "이건응끝냈습니다.", description: "끝난업무야", date: Date(), status: .done),
        Task(title: "aasdf입니다.", description: "진행중인 업무입니다.", date: Date(), status: .todo),
        Task(title: "wer무고 끝냈습니다.", description: "끝난업무야", date: Date(), status: .todo),
        Task(title: "업무를 fffff입니다.", description: "진행중인 업무입니다.", date: Date(), status: .doing),
        Task(title: "이이거 끝냈습니다.", description: "끝난업무야", date: Date(), status: .done),
        Task(title: "업잘되나요진행중입니다.", description: "진행중인 업무입니다.", date: Date(), status: .todo),
        Task(title: "이어떤가업무고 끝냈습니다.", description: "끝난업무야", date: Date(), status: .doing),
    ]
}
