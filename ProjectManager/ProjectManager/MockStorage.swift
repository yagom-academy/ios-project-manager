//
//  MockStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/12.
//

import RxRelay

protocol Storegeable {
    var todoList: BehaviorRelay<[ListItem]> { get }
    var doingList: BehaviorRelay<[ListItem]> { get }
    var doneList: BehaviorRelay<[ListItem]> { get }
    func creatList(listItem: ListItem)
    func updateList(listItem: ListItem)
    func selectItem(index: Int, type: ListType) -> ListItem
    func deleteList(index: Int, type: ListType)
    func changeListType(index: Int, type: ListType, destination: ListType)
}

final class MockStorage: Storegeable {
    let wholeList = DummyList()
    
    lazy var todoList = BehaviorRelay(value: wholeList.dummyTodoList.sorted { $0.deadline < $1.deadline })
    lazy var doingList = BehaviorRelay(value:wholeList.dummyDoingList.sorted { $0.deadline < $1.deadline })
    lazy var doneList = BehaviorRelay(value: wholeList.dummyDoneList.sorted { $0.deadline < $1.deadline })
    
    func list(_ type: ListType) -> BehaviorRelay<[ListItem]> {
        switch type {
        case .todo:
            return todoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return list(type).value[index]
    }
    
    func creatList(listItem: ListItem) {
        let type = listItem.type
        let oldList = list(type).value
        let newList = oldList + [listItem]
        
        list(type).accept(newList.sorted { $0.deadline < $1.deadline })
    }
    
    func updateList(listItem: ListItem) {
        let type = listItem.type
        var oldList = list(type).value
        
        let index = oldList.firstIndex {
            $0.id == listItem.id
        }
        
        guard let index = index else {
            return
        }
        
        oldList.remove(at: index)
        
        let newList = oldList + [listItem]

        list(type).accept(newList.sorted { $0.deadline < $1.deadline })
    }
    
    func deleteList(index: Int, type: ListType) {
        var oldList = list(type).value
        oldList.remove(at: index)
        
        list(type).accept(oldList)
    }
    
    func changeListType(index: Int, type: ListType, destination: ListType) {
        var list = selectItem(index: index, type: type)
        list.type = destination
        
        deleteList(index: index, type: type)
        creatList(listItem: list)
    }
}

final class DummyList {
    var dummyTodoList: [ListItem] = [
        ListItem(title: "안녕이요", body: "네 저는 안녕이에요?", deadline: Date(timeIntervalSince1970: 16537259728), type: .todo),
        ListItem(title: "안녕", body: "네 저는 안니근데 이렇게 죽ㅈ길게 써볼라는데 너는 뭐야!라이에요?", deadline: Date(timeIntervalSince1970: 751231235), type: .todo),
        ListItem(title: "그래맞아", body: "네 \n저는 \n그래그래에요? \n그러면 말입니다", deadline: Date(timeIntervalSince1970: 1677269760), type: .todo)
    ]
    
    var dummyDoingList: [ListItem] = [
        ListItem(title: "나는 두잉이야", body: "ㅋㄷㅋㄷ 나 알아? 난 너 몰라", deadline: Date(timeIntervalSince1970: 1677269760), type: .doing),
        ListItem(title: "안녕 나는 세잉이야", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .doing)
    ]
    
    var dummyDoneList: [ListItem] = [
        ListItem(title: "나는 던이야", body: "노래는 못불러", deadline: Date(timeIntervalSince1970: 1677269760), type: .done),
        ListItem(title: "안녕 똥이야!", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .done)
    ]
}
