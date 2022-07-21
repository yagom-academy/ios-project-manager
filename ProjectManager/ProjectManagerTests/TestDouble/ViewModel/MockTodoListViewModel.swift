//
//  MockTodoListViewModel.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import Foundation
@testable import ProjectManager

final class MockTodoListViewModel: TodoViewModelInput {
    var deleteItemCallCount = 0
    var didTapCellCallCount = 0
    var didTapFirstContextMenuCallCount = 0
    var didTapSecondContextMenuCallCount = 0
    
    func deleteItem(_ item: Todo) {
        deleteItemCallCount += 1
    }
    
    func didTapCell(_ item: Todo) {
        didTapCellCallCount += 1
    }
    
    func didTapFirstContextMenu(_ item: Todo) {
        didTapFirstContextMenuCallCount += 1
    }
    
    func didTapSecondContextMenu(_ item: Todo) {
        didTapSecondContextMenuCallCount += 1
    }
}
