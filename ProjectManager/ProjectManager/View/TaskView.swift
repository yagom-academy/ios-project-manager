//
//  TaskView.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/26.
//

import UIKit

class TaskView: UIView {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
