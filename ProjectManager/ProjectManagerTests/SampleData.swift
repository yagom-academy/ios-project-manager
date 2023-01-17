//
//  SampleData.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/17.
//

import Foundation
@testable import ProjectManager

enum SampleData {
    
    static let project1 = Project(title: "드라이 클리닝 맡기기",
                                  description: """
                                                031-XXX-XXXX
                                                파란지붕 모퉁이 사거리 왼쪽
                                                """,
                                  date: Date(),
                                  uuid: UUID())
    
    static let project2 = Project(title: "유닛 Test하기",
                                  description: "유닛테스트 진행해보기",
                                  date: Date(),
                                  uuid: UUID())
}
