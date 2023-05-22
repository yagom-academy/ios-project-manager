//
//  PlusTodoViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import Foundation
import Combine

final class PlusTodoViewModel: ObservableObject {
    @Published var todoItem: TodoItem?
    @Published var mode: Mode = .create
    
    enum Mode {
        case create, edit
    }
}
