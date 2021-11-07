//
//  EventViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation

protocol ItemViewModelInputInterface {
}

protocol ItemViewModelOutputInterface {
    var modalViewModel: DetailViewModel { get }
    var currentEvent: Event { get }
}

// 2. 관찰이 될 수 있는 오브젝트 - 인스턴스화 된 후 observedObject로 랩핑된 곳
protocol ItemViewModelable: ObservableObject {
    var input: ItemViewModelInputInterface { get }
    var output: ItemViewModelOutputInterface { get }
}

protocol Delegatable: AnyObject {
    func notifyChange()
}

class ItemViewModel: ItemViewModelable, Delegatable, Identifiable {
    func notifyChange() {
        objectWillChange.send()
    }
    
    var id: UUID = UUID()
    
    var input: ItemViewModelInputInterface { return self }
    var output: ItemViewModelOutputInterface { return self }
    
    let modalViewModel: DetailViewModel =  DetailViewModel(event: Event(title: "제목을 입력해 주세요",
                                                                                 description: "1000자까지 입력해 주세요",
                                                                                 date: Date(),
                                                                                 state: .ToDo,
                                                                                 id: UUID()))
    var currentEvent: Event {
        modalViewModel.output.event
    }
    
    init(isOnTest: Bool) {
        modalViewModel.delegate = self
    } 
}

extension ItemViewModel: ItemViewModelInputInterface {
    func onLongPressTouch() {
        
    }
}

extension ItemViewModel: ItemViewModelOutputInterface {
    func createModalVeiwModel() -> DetailViewModel {
        let modalViewModel = DetailViewModel(event: Event(title: "디테일",
                                                         description: "디테일",
                                                         date: Date(),
                                                         state: .ToDo,
                                                         id: UUID()))
        modalViewModel.delegate = self
        return modalViewModel
    }
}

