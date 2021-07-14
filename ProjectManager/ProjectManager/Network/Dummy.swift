//
//  Dummy.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/03.
//

import Foundation

// MARK: test전용 Dummy
final class Dummy {
    static let shared = Dummy()
    
    func dummy(as tableViewType: TableViewType) -> [Memo] {
        switch tableViewType {
        case .todo:
            return Dummy.shared.todo
        case .doing:
            return Dummy.shared.doing
        case .done:
            return Dummy.shared.done
        }
    }
    
    func insert(
        tableViewType: TableViewType,
        cell: Memo,
        at index: Int
    ) {
        switch tableViewType {
        case .todo:
            todo.insert(
                cell,
                at: index
            )
        case .doing:
            doing.insert(
                cell,
                at: index
            )
        case .done:
            done.insert(
                cell,
                at: index
            )
        }
    }
    
    func remove(
        tableViewType: TableViewType,
        at index: Int
    ) {
        switch tableViewType {
        case .todo:
            todo.remove(at: index)
        case .doing:
            doing.remove(at: index)
        case .done:
            done.remove(at: index)
        }
    }
    
    var dummyList: [Memo] = [
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456BE",
            title: "9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-01-07T19:32:00Z"),
            memoType: "todo"
        ),
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456B1",
            title: "doing!!!9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-09-07T19:32:00Z"),
            memoType: "doing"
        ),
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456B2",
            title: "done---9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-09-07T19:32:00Z"),
            memoType: "done"
        )
    ]
    
    
    
    // MARK: - todoDummy
    var todo: [Memo] = [
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456BE",
            title: "9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-01-07T19:32:00Z"),
            memoType: "todo"
        )
    ]
    // MARK: - doingDummy
    var doing: [Memo] = [
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456BE",
            title: "doing!!!9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-09-07T19:32:00Z"),
            memoType: "doing"
        )
    ]
    // MARK: - doneDummy
    var done: [Memo] = [
        Memo(
            id: "7B3A0149-66BA-40FD-8D3D-2296D9B456BE",
            title: "done---9123월",
            content: "콘텐츠",
            dueDate: "2021-01-07T19:32:00Z", //DateFormatter().stringToDate(string: "2021-09-07T19:32:00Z"),
            memoType: "done"
        )
    ]
}
