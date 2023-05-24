//
//  PlusTodoViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import Foundation
import Combine

final class PlusTodoViewModel: ObservableObject {
    @Published private(set) var todoItem: TodoItem?
    private(set) var mode: Mode = .create
    
    enum Mode {
        case create, edit
    }
    
    func changeMode(_ new: Mode) {
        mode = new
    }
    
    func addItem(_ item: TodoItem) {
        todoItem = item
    }
}
