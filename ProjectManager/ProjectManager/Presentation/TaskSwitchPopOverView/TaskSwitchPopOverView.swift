//
//  TaskSwitchPopOverView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class TaskSwitchPopOverView: UIViewController {
    private var doingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("DOING", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private var wholeStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        addButtonActions()
    }
}

extension TaskSwitchPopOverView {
    private func layoutViews() {
        wholeStackView.addArrangedSubview(doingButton)
        wholeStackView.addArrangedSubview(doneButton)
        view.addSubview(wholeStackView)
        view.backgroundColor = .systemGray4
        view.directionalLayoutMargins = .init(top: 8, leading: 8,
                                              bottom: 8, trailing: 8)
        
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            wholeStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            wholeStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func addButtonActions() {
        doingButton.addTarget(self, action: #selector(tapDoingButton), for: .touchDown)
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchDown)
    }
    
    @objc
    private func tapDoingButton() {
        // TODO: Add action
    }
    
    @objc
    private func tapDoneButton() {
        // TODO: Add action
    }
}
