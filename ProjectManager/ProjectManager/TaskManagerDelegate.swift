//
//  TaskManagerDelegate.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import Foundation

protocol TaskManagerDelegate: AnyObject {
    func taskDidCreated() // cell 생성 요청할 때 쓸 함수, 구현부(KanBan)에는 cell의 생성 및 삽입이 이루어짐
    func taskDidEdited() // cell 내용 수정 요청시 쓸 함수
    func taskDidDeleted(indexPath: IndexPath, status: TaskStatus) // cell 삭제 요청시 쓸 함수
}

// TaskManager에서 해아하지만 할 수 없는 일 : cell의 삭제
// 이 작업을 KanBan이 해줄거임
// 따라서 KanBan은 TaskManagerDelegate을 가지고 있을거임
