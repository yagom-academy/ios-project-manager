//
//  MockStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/12.
//

import RxRelay
protocol Storegeable {
    var list: BehaviorRelay<[ListItem]> { get }
    func creatList(listItem: ListItem)
    func updateList(listItem: ListItem)
    func deleteList(listItem: ListItem)
}

class MockStorage: Storegeable {
    private var dummyList: [ListItem] = [
        ListItem(title: "안녕이요", body: "네 저는 안녕이에요?", deadline: Date(timeIntervalSince1970: 16537259728), type: .todo),
        ListItem(title: "안녕", body: "네 저는 안니근데 이렇게 죽ㅈ길게 써볼라는데 너는 뭐야!라이에요?", deadline: Date(timeIntervalSince1970: 751231235), type: .todo),
        ListItem(title: "그래맞아", body: "네 \n저는 \n그래그래에요? \n그러면 말입니다", deadline: Date(timeIntervalSince1970: 1677269760), type: .todo),
        ListItem(title: "나는 두잉이야", body: "ㅋㄷㅋㄷ 나 알아? 난 너 몰라", deadline: Date(timeIntervalSince1970: 1677269760), type: .doing),
        ListItem(title: "안녕 나는 세잉이야", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .doing),
        ListItem(title: "나는 던이야", body: "노래는 못불러", deadline: Date(timeIntervalSince1970: 1677269760), type: .done),
        ListItem(title: "안녕 똥이야!", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .done)
    ]
    
    lazy var list = BehaviorRelay<[ListItem]>(value: dummyList)
    
    func creatList(listItem: ListItem) {
        list.accept(list.value + [listItem])
    }
    
    func updateList(listItem: ListItem) {
        list.accept(list.value.filter { listItem.id != $0.id } + [listItem])
    }
    
    func deleteList(listItem: ListItem) {
        list.accept(list.value.filter { listItem.id != $0.id })
    }
}
