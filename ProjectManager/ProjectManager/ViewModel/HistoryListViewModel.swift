//
//  HistoryListViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/13.
//

import Foundation

protocol HistoryListViewModelInput {
    func didTouchUpHistoryButton()
}

protocol HistoryListViewModelOutPut {
    var isHistoryPopoverShown: Bool { get }
    var historyViewModels: [HistoryViewModel] { get }
}

final class HistoryListViewModel: ObservableObject, HistoryListViewModelOutPut {
    @Published
    private(set) var historyViewModels: [HistoryViewModel] = []
    @Published
    var isHistoryPopoverShown = false
}

extension HistoryListViewModel: HistoryListViewModelInput {
    func didTouchUpHistoryButton() {
        isHistoryPopoverShown = true
    }
}

extension HistoryViewModel {
    private func fetch() {
        
    }
}
//TODO: Use Case, Repository, Storage 분리해서 History에 대한 flow 따로 구현하자. 
