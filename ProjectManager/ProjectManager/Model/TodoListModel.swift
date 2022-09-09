//
//  TodoListModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import Foundation

struct TodoListModel: Hashable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let deadlineDate: Date
    let cardType: CardType
}

extension TodoListModel {
   static let sample: [TodoListModel] = [TodoListModel(title: "책상정리", description: "집중이 안될땐 역시나 책상정리",
                                                       deadlineDate: Date(), cardType: .todo),
                                         TodoListModel(title: "라자냐 재료사러 가기", description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "일기쓰기", description: "난... ㄱ ㅏ끔...일ㄱ ㅣ를 쓴ㄷ ㅏ...", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "설거지하기", description: "밥을 먹었으면 응당 해야할 일", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "빨래하기", description: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "TIL 작성하기", description: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n 나중에 포트폴리오 용으로도 좋죠!", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "프로젝트 회고 작성", description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "회고 작성", description: "일 좋아 친구들 모여라 개구쟁이 뽀로로 꼬마 펭귄 나가신다", deadlineDate: Date(), cardType: .todo),
                                  TodoListModel(title: "방 정리", description: "눈 감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠 그대", deadlineDate: Date(), cardType: .todo)]
}
