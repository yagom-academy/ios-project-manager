//
//  ProjectMainViewModel.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import SwiftUI

final class ProjectMainViewModel: ObservableObject {
    @Published private var model = [Project()]

    var todoArray: [Project] {
        model.filter { $0.status == .todo }
    }
    var doingArray: [Project] {
        model.filter { $0.status == .doing }
    }
    var doneArray: [Project] {
        model.filter { $0.status == .done }
    }
}
