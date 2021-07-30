//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

final class HistoryViewModel {

    var updated: (() -> Void)?

    private(set) var histories: [History] = [] {
        didSet {
            updated?()
        }
    }

    func create(history: History) {
        histories.insert(history, at: .zero)
    }

    func history(at index: Int) -> (title: String, subtitle: String)? {
        guard index < histories.count else { return nil }

        let title: String = describe(histories[index].method)
        let subtitle: String = histories[index].date.historyFormat
        return (title, subtitle)
    }

    private func describe(_ method: History.Method) -> String {
        switch method {
        case let .added(title):
            return "Added '\(title)'"
        case let .removed(title, sourceState):
            let formattedSourceState = sourceState.rawValue.uppercased()
            return "Removed '\(title)' from \(formattedSourceState)"
        case let .moved(title, sourceState, destinationState):
            let formattedSourceState = sourceState.rawValue.uppercased()
            let formattedDestinationState = destinationState.rawValue.uppercased()
            return "Moved '\(title)' from \(formattedSourceState) to \(formattedDestinationState)"
        }
    }
}
