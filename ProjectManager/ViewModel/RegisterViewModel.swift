//
//  RegisterViewModel.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    var taskManagementService = TaskManagementService()
    
    func appendTask() {
        taskManagementService.appendData()
    }
}
