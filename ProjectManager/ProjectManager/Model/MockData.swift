//
//  MockData.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/08.
//

import Foundation

struct MockData {
    static var defaultItems: [ProjectModel] = [
        ProjectModel(
            title: "이터널스 보러가기",
            description: "용산 4d로 보고싶다",
            date: Date(timeIntervalSinceNow: 1000000000)),
        ProjectModel(
            title: "듄 또 보고싶다",
            description: "용산 아이맥스로 보고싶다",
            date: Date(timeIntervalSinceNow: -100000000)),
        ProjectModel(
            title: "제주도 놀러가기",
            description: "제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.",
            date: Date(timeIntervalSinceNow: 0)),
        ProjectModel(
            title: "제주도 놀러가기",
            description: "제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.",
            date: Date(timeIntervalSinceNow: 0))
    ]
}
