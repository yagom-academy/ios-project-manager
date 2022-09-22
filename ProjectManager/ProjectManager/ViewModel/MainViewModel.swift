//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/22.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var todo: [Todo]
    @Published var doing: [Todo]
    @Published var done: [Todo]
    
    init(data: [Todo]) {
        self.todo = data.filter { $0.status == .todo }
        self.doing = data.filter { $0.status == .doing }
        self.done = data.filter { $0.status == .done }
    }
}
