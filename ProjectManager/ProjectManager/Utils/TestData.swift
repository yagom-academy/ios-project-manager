//
//  TestData.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import Foundation

enum TestData {
    static let todoData = [
        Task(
            title: "책상정리",
            body: "집중이 안될떄 역시나 책상정리",
            date: 1600000000,
            taskType: .todo,
            id: UUID().uuidString
        ),
        Task(
            title: "라자냐 재료사러 가기",
            body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
            date: 1600000000,
            taskType: .todo,
            id: UUID().uuidString
        ),
        Task(
            title: "일기쓰기",
            body: "난... ㄱㅏ 끔... 일ㄱㅣ를 쓴 ㄷㅏ...",
            date: 1600000000,
            taskType: .todo,
            id: UUID().uuidString
        ),
        Task(
            title: "설거지하기",
            body: "밥을 먹었으면 응당 해야할 일",
            date: 1800000000,
            taskType: .todo,
            id: UUID().uuidString
        ),
        Task(
            title: "빨래하기",
            body: "그만 쌓아두고...\n근데...\n여전히 하기 싫다.",
            date: 1800000000,
            taskType: .todo,
            id: UUID().uuidString
        )
    ]
    
    static let doingData = [
        Task(
            title: "TIL 작성하기",
            body: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포프폴리오 용으로도 좋죠!",
            date: 1800000000,
            taskType: .doing,
            id: UUID().uuidString
        ),
        Task(
            title: "프로젝트 회고 작성",
            body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
            date: 1900000000,
            taskType: .doing,
            id: UUID().uuidString
        )
    ]
    
    static let doneData = [
        Task(
            title: "오늘의 할일 찾기",
            body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그 곳은 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져있을까?",
            date: 1500000000,
            taskType: .done,
            id: UUID().uuidString
        ),
        Task(
            title: "프로젝트 회고 작성",
            body: "노는 게 제일 좋아 친구들 모여라\n언제나 즐거워 개구쟁이 뽀로로\n눈 덮인 숲속 마을 꼬마 펭귄 나가신다.",
            date: 1500000000,
            taskType: .done,
            id: UUID().uuidString
        ),
        Task(
            title: "방정리",
            body: "눈감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠 그대 나 보이나요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요.",
            date: 1800000000,
            taskType: .done,
            id: UUID().uuidString
        )
    ]
}
