//
//  Project.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

struct Project: Hashable {
    
    let title: String
    let description: String
    let date: Date
}

struct TestModel {
    
    static let title = "ToDo"
    static let todos = [
        Project(title: "test용 모델 제목 1",
                description: """
                하위 버전 호환성에는 문제가 없는가?
                안정적으로 운용 가능한가?
                미래 지속가능성이 있는가?
                리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
                어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
                이 앱의 요구기능에 적절한 선택인가?
                """,
                date: Date()),
        Project(title: "2번", description: "000하기", date: Date()),
        Project(title: "3번", description: "000하기", date: Date()),
        Project(title: "4번", description: "000하기", date: Date()) ]
}
