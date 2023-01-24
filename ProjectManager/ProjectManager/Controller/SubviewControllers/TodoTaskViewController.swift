//
//  TodoTaskViewController.swift
//  ProjectManager
//
//  Created by jin on 1/24/23.
//

import UIKit

class TodoTaskViewController: TaskViewController {

    init() {
        super.init(type: .todo)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
