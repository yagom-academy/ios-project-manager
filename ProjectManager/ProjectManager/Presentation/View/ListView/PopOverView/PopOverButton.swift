//
//  PopOverButton.swift
//  ProjectManager
//
//  Created by Max on 2023/10/06.
//

import UIKit

final class ChangeStatusButton: UIButton {
    let status: ToDoStatus
    
    init(status: ToDoStatus) {
        self.status = status
        super.init(frame: .init())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.setTitle("Move to \(status.rawValue)", for: .normal)
        self.backgroundColor = .white
        self.setTitleColor(.systemBlue, for: .normal)
    }

}
