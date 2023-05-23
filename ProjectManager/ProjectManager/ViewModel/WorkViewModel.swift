//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import Foundation

final class WorkViewModel {
    var works: [Work] = []
    var currentID: UUID?
    
    init() {
        works = [
            Work(title: "제목제목제목제목제목1", body: "1설명이 세 줄 이상이면 세 ", deadline: Date()),
            Work(title: "제목제목제목제목제목2", body: "2설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목3", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목4", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목5", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목6", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목7", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목8", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(status: WorkStatus.doing.title, title: "제목제목제목제목제목1", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(status: WorkStatus.done.title, title: "제목제목제목제목제목2", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
        ]
    }
    
    func fetchWorkIndex() -> Int? {
        guard let index = works.firstIndex(where: { $0.id == currentID }) else { return nil }
        
        return index
    }
    
    func addWork(title: String, body: String, deadline: Date) {
        works.append(Work(title: title, body: body, deadline: deadline))
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func updateWork(title: String, body: String, deadline: Date) {
        guard let index = fetchWorkIndex() else { return }
        
        works[index].title = title
        works[index].body = body
        works[index].deadline = deadline
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func removeWork() {
        guard let index = fetchWorkIndex() else { return }
        
        works.remove(at: index)
    }
    
    func fetchWorkCount(of status: WorkStatus) -> Int {
        let filteredWorks = works.filter { $0.status == status.title }
        
        return filteredWorks.count
    }
    
    func fetchWork() -> Work? {
        guard let index = fetchWorkIndex() else { return nil }
        
        return works[index]
    }
}
