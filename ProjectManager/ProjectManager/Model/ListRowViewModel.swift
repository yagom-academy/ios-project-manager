//
//  EventViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation

//protocol ViewModelDelegatable {
//   func updateEvent()
//}

protocol ListRowViewModelInputInterface {
    func onLongPressTouch()
    
   // func onTouchRow() -> Event
}

protocol ListRowViewModelOutputInterface {
    var detailViewModel: DetailViewModel { get }
}

protocol ListRowViewModelable: ObservableObject {
    var input: ListRowViewModelInputInterface { get }
    var output: ListRowViewModelOutputInterface { get }
}

class ListRowViewModel: ListRowViewModelable {
    var input: ListRowViewModelInputInterface { return self }
    var output: ListRowViewModelOutputInterface { return self }
    //클래스이기 때문에 어차피 감지 못함, Published 제거, 디테일뷰모델의 변화를 알아챌 수 있는 것이 필요
    @Published var detailViewModel: DetailViewModel = DetailViewModel(event: Event(title: "디테일",
                                                                        description: "디테일",
                                                                        date: Date(),
                                                                        state: .ToDo,
                                                                        id: UUID()))
    
    init(isOnTest: Bool) {
        if isOnTest {
            self.detailViewModel = DetailViewModel(event: Event(title: "test",
                                                                description: "testtest",
                                                                date: Date(),
                                                                state: .ToDo,
                                                                id: UUID()))
        } else {
           // self.detailViewModel = detailViewModel
        }
    }
}

extension ListRowViewModel: ListRowViewModelInputInterface {
//    func onTouchRow() -> Event {
//        detailViewModel.event
//    }
    
    func onLongPressTouch() {
        
    }
}

extension ListRowViewModel: ListRowViewModelOutputInterface {

}

