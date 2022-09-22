//
//  ProjectMainViewModel.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import SwiftUI

final class ProjectMainViewModel: ObservableObject {
    @Published var model: [Project] = []
    @Published var project: Project?

    var todoArray: [Project] {
        model.filter { $0.status == .todo }
    }
    var doingArray: [Project] {
        model.filter { $0.status == .doing }
    }
    var doneArray: [Project] {
        model.filter { $0.status == .done }
    }

    func delete(at offsets: IndexSet, status: Status) {
        guard let remove = offsets.first else { return }
        let filteredArray = model.filter { todo in
            todo.status == status
        }
        model.removeAll { todo in
            todo.id == filteredArray[remove].id
        }
    }
}
