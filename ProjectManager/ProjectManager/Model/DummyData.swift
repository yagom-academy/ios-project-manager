//
//  DummyData.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import Foundation

struct DummyData {
    let data = [
        ProjectToDoList.Plan(state: .toDo, title: "의존모둠 스크럼", description: "오후 2시에 의존모둠 만나서 스크럼", deadline: Date(), isOverdue: false),
        ProjectToDoList.Plan(state: .toDo, title: "카훗 문제 출제", description: "다음주 카훗 문제 출제 목요일까지 완료해야함", deadline: Date(), isOverdue: false),
        ProjectToDoList.Plan(state: .doing, title: "프로젝트 스텝2", description: "프로젝트 스텝2 진행", deadline: Date(), isOverdue: true),
        ProjectToDoList.Plan(state: .done, title: "디자인패턴 사다리타기", description: "각자 공부할 디자인패턴 사다리타기로 뭐할지 결정해야함", deadline: Date(), isOverdue: true),
        ProjectToDoList.Plan(state: .doing, title: "점심 식사", description: "김치찌개 비조리된 거 배달시켜서 먹기", deadline: Date(), isOverdue: false)
    ]
}
