//
//  SampleData.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import Foundation

struct SampleData {
    static let todoWorks: [Work] = [
        Work(id: UUID(),
             title: "책상정리",
             content: "집중이 안될땐 역시나 책상정리",
             deadline: Date(timeIntervalSinceNow: 86400),
             state: .todo),
        Work(id: UUID(),
             title: "라자냐 재료사러 가기",
             content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
             deadline: Date(),
             state: .todo),
        Work(id: UUID(),
             title: "일기쓰기",
             content: "난... ㄱㅏ끔... 일ㄱㅣ를 쓴ㄷㅏ...",
             deadline: Date(timeIntervalSinceNow: 2000000),
             state: .todo),
        Work(id: UUID(),
             title: "설거지하기",
             content: "밥을 먹었으면 응당 해야할 일",
             deadline: Date(), state: .todo),
        Work(id: UUID(),
             title: "빨래하기",
             content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다",
             deadline: Date(timeIntervalSinceNow: -86400),
             state: .todo)
    ]
    
    static let doingWorks: [Work] = [
        Work(id: UUID(),
             title: "TIL 작성하기",
             content: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로도 좋죠!",
             deadline: Date(timeIntervalSinceNow: 86400),
             state: .doing),
        Work(id: UUID(),
             title: "프로젝트 회고 작성",
             content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요",
             deadline: Date(timeIntervalSinceNow: 86400),
             state: .doing)
    ]
    
    static let doneWorks: [Work] = [
        Work(id: UUID(),
             title: "오늘의 할일 찾기",
             content: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그 곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네",
             deadline: Date(timeIntervalSinceNow: -86400),
             state: .done),
        Work(id: UUID(),
             title: "프로젝트 회고 작성",
             content: "노는 게 제일 좋아 친구들 모여라 언제나 즐거워 개구쟁이 뽀로로 눈 덮인 숲 속 마을 꼬마 펭귄 나가신다 언제나 즐거워 오늘은 또 무슨 일이 생길까",
             deadline: Date(timeIntervalSinceNow: -86400),
             state: .done),
        Work(id: UUID(),
             title: "방정리",
             content: """
            눈감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠
            그대 나 보이나요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 그대와 영원히
            눈감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠
            그대 나 보이나요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 그대와 영원히
            """,
             deadline: Date(timeIntervalSinceNow: -86400),
             state: .done)
    ]
}
