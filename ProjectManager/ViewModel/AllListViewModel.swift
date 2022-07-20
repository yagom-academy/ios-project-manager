//
//  AllListViewModel.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import Foundation

class AllListViewModel: ObservableObject {
    @Published var todoTasks: [Task] = []
    @Published var doingTasks: [Task] = []
    @Published var doneTasks: [Task] = []
}
