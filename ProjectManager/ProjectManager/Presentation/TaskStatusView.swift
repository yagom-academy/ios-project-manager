//
//  TaskStatusView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

class TaskStatusView: UIView {
    
    var taskNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "HEllo Im title"
        return label
    }()
    var taskCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCount(count: Int) {
        self.taskCountLabel.text = count.description
    }
    
}

extension TaskStatusView {
    func configureViewLayout() {
        wholeStackView.addArrangedSubview(taskNameLabel)
        wholeStackView.addArrangedSubview(taskCountLabel)
        
        self.addSubview(wholeStackView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 80),
            wholeStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        taskNameLabel.backgroundColor = .systemPink
        taskCountLabel.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            self.taskNameLabel.widthAnchor.constraint(equalToConstant: 100),
            self.taskNameLabel.heightAnchor.constraint(equalToConstant: 40),
            self.taskNameLabel.leadingAnchor.constraint(equalTo: self.wholeStackView.leadingAnchor,
                                                        constant: -10),

            self.taskCountLabel.widthAnchor.constraint(equalToConstant: 40),
            self.taskCountLabel.heightAnchor.constraint(equalToConstant: 40),
            self.taskCountLabel.leadingAnchor.constraint(equalTo: self.taskNameLabel.trailingAnchor,
                                                         constant: 10),
            self.taskCountLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.wholeStackView.trailingAnchor)
        ])
    }
}
