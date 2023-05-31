//
//  TaskListHeaderViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskListHeaderViewModel {
    private let projectManagerService = ProjectManagerService.shared
    private var subscriptions = Set<AnyCancellable>()
    
    var title: String = ""
    @Published var count: String = ""
    
    init(state: TaskState) {
        setTitle(state: state)
        requestTaskCount(state: state)
    }
    
    private func setTitle(state: TaskState) {
        title = state.description
    }
    
    private func requestTaskCount(state: TaskState) {
        projectManagerService
            .requestTaskListPublisher()
            .map {
                $0.filter {
                    $0.state == state
                }
            }
            .map {
                String($0.count)
            }
            .assign(to: \.count, on: self)
            .store(in: &subscriptions)
    }
}
