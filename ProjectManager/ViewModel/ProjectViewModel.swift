//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/07.
//

import Foundation

class ProjectViewModel: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var body: String = ""
}
