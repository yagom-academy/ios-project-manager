//
//  CellPopoverViewController.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/17.
//

import UIKit

final class CellPopoverViewController: UIViewController {

    private let firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Move to DOING", for: .normal)
        return button
    }()

    private let secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Move to DONE", for: .normal)
        return button
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    weak var cellPopoverViewDelegate: CellPopoverViewDelegate?
    var cellToChange: CellPopoverViewMode?
    var cellIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4
        view.addSubview(verticalStackView)
        settingButtons()
        firstButton.addTarget(self, action: #selector(touchUpFirstButton(_:)), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(touchUpSecondButton(_:)), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        configureSubViews()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubViews() {
        verticalStackView.addArrangedSubview(firstButton)
        verticalStackView.addArrangedSubview(secondButton)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    private func settingButtons() {
        guard let mode = cellToChange else { return }
        switch mode {
        case .todo:
            firstButton.setTitle("Move to DOING", for: .normal)
            secondButton.setTitle("Move to DONE", for: .normal)
        case .doing:
            firstButton.setTitle("Move to TODO", for: .normal)
            secondButton.setTitle("Move to DONE", for: .normal)
        case .done:
            firstButton.setTitle("Move to TODO", for: .normal)
            secondButton.setTitle("Move to DOING", for: .normal)
        }
    }
}

// MARK: - Objc
extension CellPopoverViewController {
    @objc private func touchUpFirstButton(_ sender: UIButton) {
        guard let mode = cellToChange,
              let index = cellIndex else { return }
        switch mode {
        case .todo:
            cellPopoverViewDelegate?.moveToDoing(from: mode, cellIndex: index)
        case .doing, .done:
            cellPopoverViewDelegate?.moveToTodo(from: mode, cellIndex: index)
        }
        dismiss(animated: true)
    }

    @objc private func touchUpSecondButton(_ sender: UIButton) {
        guard let mode = cellToChange,
              let index = cellIndex else { return }
        switch mode {
        case .todo, .doing:
            cellPopoverViewDelegate?.moveToDone(from: mode, cellIndex: index)
        case .done:
            cellPopoverViewDelegate?.moveToDoing(from: mode, cellIndex: index)
        }
        dismiss(animated: true)
    }
}
