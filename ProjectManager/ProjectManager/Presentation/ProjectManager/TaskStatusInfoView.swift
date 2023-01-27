//
//  TaskStatusInfoView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

final class TaskStatusInfoView: UIView {

    // MARK: View
    
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
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskStatusInfoView {
    
    // MARK: Functions
    
    func setUpCount(count: Int) {
        taskCountLabel.text = count.description
    }
    
    func setTitle(with string: String) {
        taskNameLabel.text = string
    }

    // MARK: Layout
    
    private func configureViewLayout() {
        wholeStackView.addArrangedSubview(taskNameLabel)
        wholeStackView.addArrangedSubview(taskCountLabel)
        addSubview(wholeStackView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            wholeStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            taskNameLabel.widthAnchor.constraint(equalToConstant: 100),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            taskCountLabel.widthAnchor.constraint(equalToConstant: 40),
            taskCountLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        taskCountLabel.backgroundColor = .black
        taskCountLabel.layer.cornerRadius = 20
        taskCountLabel.clipsToBounds = true
    }
}
