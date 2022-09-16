//
//  ChangeWorkStateViewController.swift
//  ProjectManager
//
//  Created by 김주영 on 2022/09/16.
//

import UIKit

class ChangeWorkStateViewController: UIViewController {
    // MARK: - UI
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let moveButton: (String) -> UIButton = { title in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }
    
    private lazy var moveTodoButton = moveButton("Move To TODO")
    private lazy var moveDoingButton = moveButton("Move To DOING")
    private lazy var moveDoneButton = moveButton("Move To DONE")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: - Methods
    func setupView(for work: Work) {
        switch work.state {
        case .todo:
            verticalStackView.addArrangedSubview(moveDoingButton)
            verticalStackView.addArrangedSubview(moveDoneButton)
        case .doing:
            verticalStackView.addArrangedSubview(moveTodoButton)
            verticalStackView.addArrangedSubview(moveDoneButton)
        case .done:
            verticalStackView.addArrangedSubview(moveTodoButton)
            verticalStackView.addArrangedSubview(moveDoingButton)
        }
    }
    
    private func setupConstraints() {
        self.view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            verticalStackView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            verticalStackView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
