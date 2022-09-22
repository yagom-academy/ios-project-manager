//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/11.
//

import UIKit

final class PopoverViewController: UIViewController {
    
    private enum Transition {
        static let moveToTodo = "Move to TODO"
        static let moveToDoing = "Move to DOING"
        static let moveToDone = "Move to DONE"
    }
    
    // MARK: - UIComponents
    private let verticalStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.vertical)
        .setSpacing(5)
        .setDistribution(.fillEqually)
        .useLayoutMargin()
        .setLayoutMargin(top: 10,
                         left: 10,
                         bottom: 10,
                         right: 10)
        .stackView
    
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
    
    // MARK: - Properties
    private var viewModel: PopoverViewModel
    
    // MARK: - Initializer
    init(viewModel: PopoverViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupButton()
    }
    
    // MARK: - Methods
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
        switch viewModel.selectedTodo.category {
        case Category.todo:
            setTitle(
                firstButtonTitle: Transition.moveToDoing,
                secondButtonTitle: Transition.moveToDone
            )
            addTarget(
                firstButtonTarget: #selector(moveToDoing),
                secondButtonTarget: #selector(moveToDone)
            )
        case Category.doing:
            setTitle(
                firstButtonTitle: Transition.moveToTodo,
                secondButtonTitle: Transition.moveToDone
            )
            addTarget(
                firstButtonTarget: #selector(moveToTodo),
                secondButtonTarget: #selector(moveToDone)
            )
        case Category.done:
            setTitle(
                firstButtonTitle: Transition.moveToTodo,
                secondButtonTitle: Transition.moveToDoing
            )
            addTarget(
                firstButtonTarget: #selector(moveToTodo),
                secondButtonTarget: #selector(moveToDoing)
            )
        default:
            return
        }
    }
    
    private func setTitle(firstButtonTitle: String,
                          secondButtonTitle: String) {
        firstButton.setTitle(firstButtonTitle,
                             for: .normal)
        secondButton.setTitle(secondButtonTitle,
                              for: .normal)
    }
    
    private func addTarget(firstButtonTarget: Selector,
                           secondButtonTarget: Selector) {
        firstButton.addTarget(
            self,
            action: firstButtonTarget,
            for: .touchUpInside
        )
        secondButton.addTarget(
            self,
            action: secondButtonTarget,
            for: .touchUpInside
        )
    }
    
    // MARK: - @objc Methods
    @objc private func moveToDoing() {
        viewModel.move(to: Category.doing)
        dismiss(animated: true)
    }
    
    @objc private func moveToDone() {
        viewModel.move(to: Category.done)
        dismiss(animated: true)
    }
    
    @objc private func moveToTodo() {
        viewModel.move(to: Category.todo)
        dismiss(animated: true)
    }
}
