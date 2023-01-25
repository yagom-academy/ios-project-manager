//
//  TaskStatusView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

class TaskStatusView: UIView {
    
    private var taskNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        return label
    }()
    private var taskCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 20
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
    
    func setTitle(with string: String) {
        self.taskNameLabel.text = string
    }
    
}

extension TaskStatusView {
    private func configureViewLayout() {
        wholeStackView.addArrangedSubview(taskNameLabel)
        wholeStackView.addArrangedSubview(taskCountLabel)
        
        self.addSubview(wholeStackView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 80),
            wholeStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        taskCountLabel.backgroundColor = .black
        NSLayoutConstraint.activate([
            self.taskNameLabel.widthAnchor.constraint(equalToConstant: 100),
            self.taskNameLabel.heightAnchor.constraint(equalToConstant: 40),
            self.taskCountLabel.widthAnchor.constraint(equalToConstant: 40),
            self.taskCountLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        taskCountLabel.layer.cornerRadius = 20
        taskCountLabel.clipsToBounds = true
    }
}
