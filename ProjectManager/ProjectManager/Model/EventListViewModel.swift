////
////  EventListViewModel.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/11/04.
////
//
import Foundation
import UIKit

protocol ListViewModelInputInterface {
    func onDeleteRow(at indexSet: IndexSet)
    func onAddEvent() 
}

protocol ListViewModelOutputInterface {
    var itemViewModels: [ItemViewModel] { get }
}

protocol ListViewModelable: ObservableObject {
    var input: ListViewModelInputInterface { get }
    var output: ListViewModelOutputInterface { get }
}

class EventListViewModel: ListViewModelable {
    var input: ListViewModelInputInterface { return self }
    var output: ListViewModelOutputInterface { return self }

    @Published var itemViewModels = [ItemViewModel(isOnTest: true)]
}

extension EventListViewModel: ListViewModelInputInterface {
    func onDeleteRow(at indexSet: IndexSet) {
        self.itemViewModels.remove(atOffsets: indexSet)
        print("셀 삭제")
    }
    
    func onAddEvent() {
        self.itemViewModels.append(ItemViewModel(isOnTest: true))
    }
}

extension EventListViewModel: ListViewModelOutputInterface {
}
