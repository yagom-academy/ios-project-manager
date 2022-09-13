//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/11.
//

import UIKit

class PopoverViewController: UIViewController {
    
    private enum Kind {
        static let moveToTodo = "Move to TODO"
        static let moveToDoing = "Move to DOING"
        static let moveToDone = "Move to DONE"
    }
    
    private var viewModel: PopoverViewModel?
    
    // MARK: - UIComponents
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10,
                                               left: 10,
                                               bottom: 10,
                                               right: 10)
        return stackView
    }()

    private var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor.systemBlue,
            for: .normal
        )
        button.backgroundColor = .white
        return button
    }()

    private var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor.systemBlue,
            for: .normal
        )
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupButton()
    }
    
    // MARK: - Methods
    static func create(with viewModel: PopoverViewModel) -> PopoverViewController {
        let viewController = PopoverViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private func setupInitialView() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(firstButton)
        verticalStackView.addArrangedSubview(secondButton)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func setupButton() {
        switch viewModel?.selectedCategory {
        case .todo:
            setTitle(
                firstButtonTitle: Kind.moveToDoing,
                secondButtonTitle: Kind.moveToDone
            )
            addTarget(
                firstButtonTarget: #selector(moveToDoing),
                secondButtonTarget: #selector(moveToDone)
            )
        case .doing:
            setTitle(
                firstButtonTitle: Kind.moveToTodo,
                secondButtonTitle: Kind.moveToDone
            )
            addTarget(
                firstButtonTarget: #selector(moveToTodo),
                secondButtonTarget: #selector(moveToDone)
            )
        case .done:
            setTitle(
                firstButtonTitle: Kind.moveToTodo,
                secondButtonTitle: Kind.moveToDoing
            )
            addTarget(
                firstButtonTarget: #selector(moveToTodo),
                secondButtonTarget: #selector(moveToDoing)
            )
        case .none:
            return
        }
    }
    
    private func setTitle(firstButtonTitle: String, secondButtonTitle: String) {
        firstButton.setTitle(firstButtonTitle, for: .normal)
        secondButton.setTitle(secondButtonTitle, for: .normal)
    }
    
    private func addTarget(firstButtonTarget: Selector, secondButtonTarget: Selector) {
        firstButton.addTarget(self, action: firstButtonTarget, for: .touchUpInside)
        secondButton.addTarget(self, action: secondButtonTarget, for: .touchUpInside)
    }
    
    @objc private func moveToDoing() {
        viewModel?.move(to: .doing)
        dismiss(animated: true)
    }
    
    @objc private func moveToDone() {
        viewModel?.move(to: .done)
        dismiss(animated: true)
    }
    
    @objc private func moveToTodo() {
        viewModel?.move(to: .todo)
        dismiss(animated: true)
    }
}
