//
//  Todo.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

enum TodoStatus: Identifiable {
    case todo
    case doing
    case done
    
    var id: String {
        return self.title
    }
    
    var title: String {
        switch self {
        case .todo: return "TODO"
        case .doing: return "DOING"
        case .done: return "DONE"
        }
    }
}

struct Todo {
    var title: String
    var description: String
    var dueDate: Date
    var status: TodoStatus
}

extension Todo {
    static func generateMockTodos() -> [Todo] {
        return [
            Todo(title: "책상정리",
                 description: "집중이 안될 땐 역시나 책상정리",
                 dueDate: Date(year: 2021, month: 11, day: 5)!,
                 status: .todo),
            Todo(title: "라자냐 재료사러 가기",
                 description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
                 dueDate: Date(year: 2019, month: 1, day: 5)!,
                 status: .todo),
            Todo(title: "일기쓰기",
                 description: "난... ㄱ ㅏ 끔... 일ㄱ ㅣ를 쓴 ㄷ ㅏ...",
                 dueDate: Date(year: 2021, month: 3, day: 6)!,
                 status: .todo),
            Todo(title: "설거지하기",
                 description: "밥을 먹었으면 응당 해야할 일",
                 dueDate: Date(year: 2020, month: 12, day: 6)!,
                 status: .todo),
            Todo(title: "빨래하기",
                 description: "그만 쌓아두고...\n근데...\n여전히 하기 싫다.",
                 dueDate: Date(year: 2022, month: 12, day: 25)!,
                 status: .todo),
            
            Todo(title: "TIL 작성하기",
                 description: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로도 좋죠!",
                 dueDate: Date(year: 2021, month: 3, day: 1)!,
                 status: .doing),
            Todo(title: "프로젝트 회고 작성",
                 description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서\n무엇을 놓쳤는지 명확히 알 수 있어요.",
                 dueDate: Date(year: 2021, month: 11, day: 25)!,
                 status: .doing),
            
            Todo(title: "오늘의 할일 찾기",
                 description: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져있어쩌구저쩌구그런데말이야.",
                 dueDate: Date(year: 2021, month: 12, day: 9)!,
                 status: .done),
            Todo(title: "회고작성",
                 description: "노는 게 제일 좋아 친구들 모여라\n언제나 즐거워 개구쟁이 뽀로로\n눈 덮인 숲속 마을 꼬마 펭귄 나가신다 길을 비켜라.",
                 dueDate: Date(year: 2023, month: 1, day: 29)!,
                 status: .done),
            Todo(title: "방정리",
                 description: "눈감고 그댈 그려요 맘속 그댈 찾았죠. 나를 발겨후는 및이 보여 영원히 행복을 놓칠 순 없죠 그대 나 보이나요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 그대와 Don't worry",
                 dueDate: Date(year: 2019, month: 7, day: 17)!,
                 status: .done)
        ]
    }
}

extension Date {
    init?(year: Int, month: Int, day: Int) {
        let dateComponent = DateComponents(year: year, month: month, day: day)
        guard let date = Calendar.current.date(from: dateComponent) else {
            return nil
        }

        self = date
    }
}
