//
//  ProjectManager - MoveToViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class MoveToViewController: UIViewController {
    var projectManagerViewController: ProjectManagerViewController?
    let status: Status?
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let moveToTodoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to TODO", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(gray: 0, alpha: 0)
        button.layer.shadowOffset = .init(width: 10, height: 10)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        
        return button
    }()
    
    private let moveToDoingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to DOING", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private let moveToDoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to DONE", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    init(projectManagerViewController: ProjectManagerViewController? = nil, status: Status? = nil) {
        self.projectManagerViewController = projectManagerViewController
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        guard let status else { return }
        configureContentStackView(status: status)
        configureConstraint()
    }
    
    func configureContentStackView(status: Status) {
        view.addSubview(contentStackView)
        
        switch status {
        case .todo:
            contentStackView.addArrangedSubview(moveToDoingButton)
            contentStackView.addArrangedSubview(moveToDoneButton)
        case .doing:
            contentStackView.addArrangedSubview(moveToTodoButton)
            contentStackView.addArrangedSubview(moveToDoneButton)
        case .done:
            contentStackView.addArrangedSubview(moveToTodoButton)
            contentStackView.addArrangedSubview(moveToDoingButton)
        }
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    
}
