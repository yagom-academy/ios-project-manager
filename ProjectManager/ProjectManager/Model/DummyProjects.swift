//
//  DummyProjects.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import Foundation

struct DummyProjects {
    static var projects: [Project] = [
        Project(id: UUID(),
                status: .todo,
                title: "SwiftUI공부하기",
                detail: "SwiftUI를 공부한다",
                date: Date()),
        Project(id: UUID(), status: .todo,
                title: "오늘자 일일회고 작성하기",
                detail: "일일회고는 생명이니까 반드시 작성해야지",
                date: Date()),
        Project(id: UUID(),
                status: .doing,
                title: "프로젝트 매니저 Step2 진행하기",
                detail: "프로젝트 매니저 Step2 진행하면서 리드미도 잘 작성하기",
                date: Date()),
        Project(id: UUID(),
                status: .doing,
                title: "아이패드 미니 6 맞을 준비하기",
                detail: "아싸아싸 아이패드 미니 곧 온다~~ 진짜 진짜 기대중인데 얼마나 이쁠지 상상도 안간다. 빨리 와서 내 마음을 아이패드가 녹여줬으면 좋겠다. 퍼플, 스타라이트, 핑크 다 저리가라고 해라 스페이스 그레이가 최고 존엄 이시다. 왜냐? 최고존엄이기때문이다. 3줄 이상 글을 작성할라고 이렇게 많이 작성하고 있는데 솔직히 쫌 현타온다.",
                date: Date()),
        Project(id: UUID(),
                status: .done,
                title: "SwiftUI 강의하기",
                detail: "3기 캠퍼에게 SwiftUI 강의를 진행해야한다.",
                date: Date()),
        Project(id: UUID(),
                status: .done,
                title: "야곰 아카데미 교육용 아티클 작성",
                detail: "야곰아카데미 블로그에 야곰 아카데미의 교육적 방향성에 대한 글 작성",
                date: Date()),
        Project(id: UUID(),
                status: .todo,
                title: "Monterey 업데이트",
                detail: "업무용 mac 말고 개인용 mac에 Monterey 업데이트 할 것",
                date: Date()),
        Project(id: UUID(),
                status: .done,
                title: "캠퍼 회식 참여하기",
                detail: "할로윈 맞이 캠퍼 회식을 참여하자. 재미있을 것 같다.",
                date: Date()),
        Project(id: UUID(),
                status: .doing,
                title: "핸드폰 충전하기",
                detail: "얼마나 쓸게 없었으면 핸드폰 충전하기를 썼겠냐..",
                date: Date()),
        Project(id: UUID(),
                status: .doing,
                title: "저녁에 커피 안마시기 챌린지",
                detail: "저녁 6시 이후에 커피 안마셔야한다. 카페인 때문에 하루가 중독되고 있다.",
                date: Date())
    ]
}
