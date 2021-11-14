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
    private let historyUseCase: HistoryUseCaseable
    
    init(historyUseCase: HistoryUseCaseable = HistoryUseCase()) {
        self.historyUseCase = historyUseCase
    }
}

extension HistoryListViewModel: HistoryListViewModelInput {
    func didTouchUpHistoryButton() {
        isHistoryPopoverShown = true
        fetch()
    }
}

extension HistoryListViewModel {
    private func fetch() {
        historyUseCase.fetch { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let histories):
                DispatchQueue.main.async {
                    self.historyViewModels = histories.map { HistoryViewModel(history: $0) }
                }
            case.failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
