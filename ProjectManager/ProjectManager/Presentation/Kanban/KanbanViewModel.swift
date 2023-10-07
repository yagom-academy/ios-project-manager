//
//  KanbanViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//
import SwiftUI

final class KanbanViewModel: ObservableObject {
    @Published var isFormOn: Bool = false
    @Published var selectedTask: Task? = nil
    
    func setFormVisible(_ isVisible: Bool) {
        isFormOn = isVisible
    }
    
    func setFormVisible(_ task: Task?) {
        selectedTask = task
    }
}
