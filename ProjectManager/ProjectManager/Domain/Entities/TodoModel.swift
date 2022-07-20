//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation

enum State {
    case todo
    case doing
    case done
}

struct TodoModel: Equatable {
    var title: String?
    var body: String?
    var deadlineAt: Date
    var state: State
    let id: UUID
    
    init(title: String? = nil,
         body: String? = nil,
         deadlineAt: Date = Date(),
         state: State = .todo,
         id: UUID = UUID()) {
        self.title = title
        self.body = body
        self.deadlineAt = deadlineAt
        self.state = state
        self.id = id
    }
}

#if DEBUG
extension TodoModel {
    static func makeDummy() -> [TodoModel] {
        return [
            TodoModel(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", deadlineAt: Date(), state: .todo),
            TodoModel(title: "라자냐 재료", body:  "프로젝트 회고를 작성하면 내가 이번 프로젝트에서\n무엇을 놓쳤는지 명확히 알 수 있어요", deadlineAt: Date(), state: .todo),
            TodoModel(title: "일기쓰기", body: "난.. ㄱ ㅏ끔...읽ㄱㅣ를 쓴ㄷㅏ...", deadlineAt: Date(), state: .todo),
            TodoModel(title: "TIL 작성하기", body: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로도 좋죠!", deadlineAt: Date(), state: .doing),
            TodoModel(title: "프로젝트 회고 작성", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서\n무엇을 놓쳤는지 명확히 알 수 있어요", deadlineAt: Date(), state: .doing),
            TodoModel(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네", deadlineAt: Date(), state: .done),
            TodoModel(title: "회고 작성", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네", deadlineAt: Date(), state: .done),
            TodoModel(title: "방정리", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네", deadlineAt: Date(), state: .done),
        ]
    }
}
#endif
