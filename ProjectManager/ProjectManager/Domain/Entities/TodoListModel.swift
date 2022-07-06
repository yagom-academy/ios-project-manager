//
//  Model.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import Foundation

struct TodoListModel: Hashable {
    let title: String
    let content: String
    let deadLine: Date
    var processType: ProcessType
}

#if DEBUG
extension TodoListModel {
    static func dummyData() -> [TodoListModel] {
        [
            TodoListModel(title: "책상정리1", content: "더미데이터더미데이터\n더미데이터더미데이터\n더미데이터더미데이터\n더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "라자냐 재료사러 가기2", content: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n 나중에 포트폴리오 용으로도 좋죠!", deadLine: Date(), processType: .done),
            TodoListModel(title: "일기쓰기3", content: "더미데이터더미데이터", deadLine: Date(), processType: .todo),
            TodoListModel(title: "설거지하기4", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "빨래하기5", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "더미데이터입니다6", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "더미데이터입니다7", content: "더미데이터더미데이터", deadLine: Date(), processType: .done),
            TodoListModel(title: "더미데이터입니다8", content: "더미데이터더미데이터", deadLine: Date(), processType: .todo),
            TodoListModel(title: "더미데이터입니다9", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "더미데이터입니다10", content: "더미데이터더미데이터", deadLine: Date(), processType: .todo),
            TodoListModel(title: "더미데이터입니다11", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
            TodoListModel(title: "더미데이터입니다12", content: "더미데이터더미데이터", deadLine: Date(), processType: .done),
            TodoListModel(title: "더미데이터입니다13", content: "더미데이터더미데이터", deadLine: Date(), processType: .doing),
        ]
    }
}
#endif

enum ProcessType {
    case todo
    case doing
    case done
}
