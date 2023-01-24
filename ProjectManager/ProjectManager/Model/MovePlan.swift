//
//  MovePlan.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/24.
//

import UIKit

final class MovePlan {
    let beforeProcess: Process
    let view: UIView
    let index: Int
    
    init(process: Process, view: UIView, index: Int) {
        self.beforeProcess = process
        self.view = view
        self.index = index
    }
}
