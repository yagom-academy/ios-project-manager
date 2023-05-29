//
//  TodoListData.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/29.
//

import Foundation

struct TodoListData {
    private let todoList = [TodoLabel(title: "책상정리", content: "집중이 안될때 역시나 책상정리", date: Date()), TodoLabel(title: "일기정리", content: "난 가끔 일기를 쓴다", date: Date()), TodoLabel(title: "빨래하기", content: "그만 쌓아두고 싶다....", date: Date())]
    private let doingList = [TodoLabel(title: "Hi!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!", content: "is a peninsular region in East Asia. Since 1945, it has been divided at or near the 38th parallel, with North Korea (Democratic People's Republic of Korea) comprising its northern half and South Korea (Republic of Korea) comprising its southern half. Korea consists of the Korean Peninsula, Jeju Island, and several minor islands near the peninsula. The peninsula is bordered by China (Manchuria) to the north and Russia to the northeast, across the Amrok and Duman rivers. It is separated from Japan to the southeast by the Korea Strait.", date: Date()), TodoLabel(title: "Hello~", content: "Brody!", date: Date())]
    private let doneList = [TodoLabel(title: "방정리", content: "눈감고 그댈 그려요 맘속 그댈 찾았죠", date: Date())]
    
}
