//
//  Todo.swift
//  ProjectManager
//
//  Created by tae hoon park on 2021/11/01.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var type: SortType
//    static let dummyToDoList = [
//            Todo(id: UUID(), title: "할일",
//                     description: "오늘은 설거지를 할게여",
//                     date: 1635405050, type: .toDo),
//            Todo(id: UUID(), title: "빨래하자",
//                     description: "빨래 꼬ㅗ고고",
//                     date: 1635318650, type: .toDo),
//            Todo(id: UUID(), title: "빨래하자",
//                     description: """
//    룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰
//    룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰
//    룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰
//    룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰룰룰루루루루룰
//    """,
//                     date: 1633849850, type: .toDo),
//            Todo(id: UUID(),
//                     title: "스텝2 진행하기", description: "스텝2 꼭하즈아~", date: 1633849850, type: .doing),
//
//            Todo(id: UUID(), title: "유투브보기",
//                     description: "오늘은 유튜브 먹방을 보겠습니다.",
//                     date: 1635405050, type: .done),
//            Todo(id: UUID(), title: "SwiftUI 공부하기",
//                     description: "이것은 혁신인가?",
//                     date: 1635405050, type: .done),
//            Todo(id: UUID(), title: "춤춰요",
//                     description: """
//    예써비어 워멘 예싸비어 걸 예써비어 워멘 예싸비어 걸
//    예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸
//    예써비어 워멘 예싸비어 걸 예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸
//    예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸
//    예써비어 워멘 예싸비어 걸 예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸
//    예써비어 워멘 예싸비어 걸 예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸예써비어 워멘 예싸비어 걸
//    """,
//                     date: 1635405050, type: .done),
//            Todo(id: UUID(), title: "하는중",
//                     description: "공부중입니다.",
//                     date: 1635405050, type: .doing),
//            Todo(id: UUID(), title: "밥먹는중",
//                     description: "밥먹어요",
//                     date: 1635405050, type: .doing),
//            Todo(id: UUID(), title: "노래불러요",
//                     description: """
//    달이 익어가니 서둘러 젊은 피야
//                     민들레 한 송이 들고
//                     사랑이 어지러이 떠다니는 밤이야
//                     날아가 사뿐히 이루렴
//                     팽팽한 어둠 사이로
//                     떠오르는 기분
//                     이 거대한 무중력에 혹 휘청해도
//                     두렵진 않을 거야
//                     푸르른 우리 위로
//                     커다란 strawberry moon 한 스쿱
//                     나에게 너를 맡겨볼래 eh-oh
//                     바람을 세로질러
//                     날아오르는 기분 so cool
//                     삶이 어떻게 더 완벽해 ooh
//                     다시 마주하기 어려운 행운이야
//                     온몸에 심장이 뛰어
//                     Oh 오히려 기꺼이 헤매고픈 밤이야
//                     너와 길 잃을 수 있다면
//                     맞잡은 서로의 손으로
//                     출입구를 허문
//                     이 무한함의 끝과 끝 또 위아래로
//                     비행을 떠날 거야
//                     푸르른 우리 위로
//                     커다란 strawberry moon 한 스쿱
//                     나에게 너를 맡겨볼래 eh-oh
//                     바람을 세로질러
//                     날아오르는 기분 so cool
//                     삶이 어떻게 더 완벽해 ooh
//                     놀라워 이보다
//                     꿈같은 순간이 또 있을까 (더 있을까)
//                     아마도 우리가 처음 발견한
//                     오늘 이 밤의 모든 것, 그 위로 날아
//                     푸르른 우리 위로
//                     커다란 strawberry moon 한 스쿱
//                     세상을 가져보니 어때 eh-oh
//                     바람을 세로질러
//                     날아오르는 기분 so cool
//                     삶이 어떻게 더 완벽해 ooh
//    """,
//                     date: 1635405050, type: .doing)
//        ]
}
//
enum SortType: CustomStringConvertible {
    case toDo
    case doing
    case done

    var description: String {
        switch self {
        case .toDo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
