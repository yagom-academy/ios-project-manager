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
}

final class HistoryListViewModel: ObservableObject, HistoryListViewModelOutPut {
    @Published
    var isHistoryPopoverShown = false
}

extension HistoryListViewModel: HistoryListViewModelInput {
    func didTouchUpHistoryButton() {
        isHistoryPopoverShown = true
    }
}
