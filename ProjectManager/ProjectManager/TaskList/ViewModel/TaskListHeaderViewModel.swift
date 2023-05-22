//
//  TaskListHeaderViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskListHeaderViewModel {
    private let taskManager = TaskManager.shared
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var title: String = ""
    @Published var count: String = ""
    
    init(state: State) {
        setTitle(state: state)
        requestTaskCount(state: state)
    }
    
    private func setTitle(state: State) {
        title = state.description
    }
    
    private func requestTaskCount(state: State) {
        taskManager
            .taskListPublisher()
            .map {
                $0.filter {
                    $0.state == state
                }
            }
            .count()
            .map { String($0) }
            .assign(to: \.count, on: self)
            .store(in: &subscriptions)
    }
}
