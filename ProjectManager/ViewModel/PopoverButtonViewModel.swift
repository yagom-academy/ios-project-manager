//
//  PopoverButtonViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class PopoverButtonViewModel: ViewModelType {
    func moveData(_ task: Task, from: TaskType, to: TaskType) {
        guard let item = service.tasks.filter({ $0 == task }).first else {
            return
        }
        
        guard let index = service.tasks.firstIndex(of: item) else {
            return
        }
        
        var newItem = item
        newItem.type = to
        service.tasks.remove(at: index)
        service.tasks.append(newItem)
    }
}
