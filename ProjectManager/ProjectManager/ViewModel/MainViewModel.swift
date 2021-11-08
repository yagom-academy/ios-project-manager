//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

protocol MainViewModelInputInterface {
    func onTouchEventCreateButton()
}

protocol MainViewModelOutputInterface {
    var eventListViewModel: EventListViewModel { get }
    var currentEvetDetailViewModel: DetailViewModel? { get }
}

protocol MainViewModelable: ObservableObject {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

class ProjectManager: MainViewModelable {
    func notifyChange() {
        objectWillChange.send()
    }
    
    var output: MainViewModelOutputInterface { return self }
    var input: MainViewModelInputInterface { return self }

    @Published var eventListViewModel = EventListViewModel()
    
    var currentEvetDetailViewModel: DetailViewModel? {
        self.eventListViewModel.output.itemViewModels.last!.detailViewModel
    }
}

extension ProjectManager: MainViewModelInputInterface {
    func onTouchEventCreateButton() {
        self.eventListViewModel.input.onAddEvent()
    }
}

extension ProjectManager: MainViewModelOutputInterface {
    
}
