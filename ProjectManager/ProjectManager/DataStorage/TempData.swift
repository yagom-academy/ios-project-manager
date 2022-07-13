//
//  TempData.swift
//  TodoListViewModel+Fixture
//
//  Created by 김동욱 on 2022/07/11.
//

import Foundation

struct TempData {
    init() {}
    
    let todoData = [
        "todoListItemStatus": "TODO",
        "title": "책상정리",
        "description": "집중이 안될때 역시나 책상정리",
        "date": "2022. 7. 11.",
    ]
    
    let doneData = [
        "todoListItemStatus": "DONE",
        "title": "TIL 작성하기",
        "description": "TIL 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로 좋죠!",
        "date": "2022. 7. 11.",
    ]
    
    let doingData = [
        "todoListItemStatus": "DOING",
        "title": "오늘의 할일 찾기",
        "description": "내가 가는 이길이 어디로 가는지 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있지 내가 가는 길이 어디로 가는지 잘 모르겠지만 활 수 있따!",
        "date": "2022. 7. 11.",
    ]
}
