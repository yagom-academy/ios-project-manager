//
//  SampleData.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/17.
//

import Foundation

struct SampleDummyData {
            
    var sampleDummy: [Task] {
        var tasks = [Task]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy .MM .dd"
        tasks.append(Task(title: "첫번째업무", description: "첫업무입니다.", date: dateFormatter.date(from: "2011 .11 .13"), status: .todo))
        tasks.append(Task(title: "업무를 진행중입니다.", description: "진행중인 업무입니다.", date: Date(), status: .todo))
        tasks.append(Task(title: "이건이거쎌.", description: "끝난업무야", date: dateFormatter.date(from: "2012 .11 .13"), status: .done))
        tasks.append(Task(title: "굿ios다.", description: "진행중인 업무입니다.", date: dateFormatter.date(from: "2023 .1 .30"), status: .done))
        tasks.append(Task(title: "이거예시니다.", description: "끝난업무야", date: dateFormatter.date(from: "2024 .5 .20"), status: .done))
        tasks.append(Task(title: "업되나진행중입니다.", description: "진행중인 업무입니다.", date: dateFormatter.date(from: "2016 .2 .13"), status: .todo))
        tasks.append(Task(title: "이건응끝냈습니다.", description: "끝난업무야", date: dateFormatter.date(from: "1994 .6 .22"), status: .done))
        tasks.append(Task(title: "aasdf입니다.", description: "진행중인 업무입니다.", date: dateFormatter.date(from: "2033 .11 .13"), status: .todo))
        tasks.append(Task(title: "wer무고 끝냈습니다.", description: "끝난업무야", date: dateFormatter.date(from: "2012 .11 .24"), status: .todo))
        tasks.append(        Task(title: "업무를 fffff입니다.", description: "진행중인 업무입니다.", date: dateFormatter.date(from: "2021 .10 .8"), status: .doing))
        tasks.append( Task(title: "이이거 끝냈습니다.", description: "끝난업무야", date: dateFormatter.date(from: "2009 .12 .3"), status: .done))
        tasks.append(Task(title: "업잘되나요진행중입니다.", description: "진행중인 업무입니다.", date: dateFormatter.date(from: "2007 .12 .3"), status: .todo))
        tasks.append(Task(title: "이어떤가업무고 끝냈습니다.", description: "끝난업무야", date: dateFormatter.date(from: "2006 .6 .22"), status: .doing))
        return tasks
    }
    
}
