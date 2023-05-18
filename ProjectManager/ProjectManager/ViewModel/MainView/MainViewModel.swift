//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import Foundation

final class MainViewModel {
    var works: [Work] = []
    
    init() {
        works = [
            Work(title: "제목제목제목제목제목1", body: "1설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목2", body: "2설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date()),
            Work(title: "제목제목제목제목제목3", body: "3설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: Date())
        ]
    }
}
