//
//  ModelData.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var memos: [Memo] = memoExample
    
    var newMemo: Memo {
        Memo(title: "", body: "", deadline: .now, category: .toDo)
    }
    
    func filterMemo(by category: Memo.Category) -> [Memo] {
        memos.filter { $0.category == category }
    }
    
    func saveMemo(_ memo: Memo) {
        guard let index = memos.firstIndex(where: { $0.id == memo.id }) else {
            memos.append(memo)
            return
        }
        memos[index] = memo
    }
}

extension ModelData {
    private static let memoExample: [Memo] = [
        Memo(title: "저녁 재료 주문하기🍅",
             body: "- 파스타면\n- 베이컨\n- 토마토\n- 치즈\n- 생크림",
             deadline: Calendar.current.date(byAdding: .day, value: 0, to: .now) ?? .now,
             category: .toDo),
        Memo(title: "STEP2-1 PR 보내기💻",
             body: "문제점 수정 후 PR 작성",
             deadline: Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now,
             category: .toDo),
        Memo(title: "11월까지 돈 모으기!💵",
             body: "일주일에 만원씩 모아보자",
             deadline: Calendar.current.date(byAdding: .day, value: 40, to: .now) ?? .now,
             category: .doing),
        Memo(title: "STEP1 PR 보내기📮",
             body: "기술 스텍 선정 및 firebase 설치",
             deadline: Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .now,
             category: .done),
        Memo(title: "친구 생일 선물 고르기🎁",
             body: "뭐 좋아하려나...🤔",
             deadline: Calendar.current.date(byAdding: .day, value: -10, to: .now) ?? .now,
             category: .done),
        Memo(title: "TIL 작성하기📝",
             body: "Swift Concurrency 정리해야돼에엥",
             deadline: Calendar.current.date(byAdding: .day, value: 3, to: .now) ?? .now,
             category: .toDo)
    ]
}
