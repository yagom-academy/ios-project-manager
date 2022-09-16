//
//  ProjectModalViewModel.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import SwiftUI

final class ProjectModalViewModel: ObservableObject {
    var project: Project

    @Published var title: String
    @Published var detail: String
    @Published var date: Date
    @Published var id: UUID
    @Published var status: Status
    @Published var placeholder: String

    init(project: Project = Project()) {
        self.project = project
        self.title = project.title ?? ""
        self.detail = project.detail ?? ""
        self.date = project.date ?? Date()
        self.id = project.id ?? UUID()
        self.status = project.status ?? .todo
        self.placeholder = project.placeholder
    }
}
