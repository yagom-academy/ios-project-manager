//
//  CellPopoverViewController.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/17.
//

import UIKit

final class CellPopoverViewController: UIViewController {

    private let poppverFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Move to DOING", for: .normal)
        return button
    }()

    private let popoverSecondButton: UIButton = {
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
        poppverFirstButton.addTarget(self, action: #selector(touchUpFirstButton(_:)), for: .touchUpInside)
        popoverSecondButton.addTarget(self, action: #selector(touchUpSecondButton(_:)), for: .touchUpInside)
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
        let spacing: CGFloat = 8
        let largeSpacing: CGFloat = 20

        verticalStackView.addArrangedSubview(poppverFirstButton)
        verticalStackView.addArrangedSubview(popoverSecondButton)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -largeSpacing)
        ])
    }

    private func settingButtons() {
        guard let mode = cellToChange else { return }
        switch mode {
        case .todo:
            poppverFirstButton.setTitle("Move to DOING", for: .normal)
            popoverSecondButton.setTitle("Move to DONE", for: .normal)
        case .doing:
            poppverFirstButton.setTitle("Move to TODO", for: .normal)
            popoverSecondButton.setTitle("Move to DONE", for: .normal)
        case .done:
            poppverFirstButton.setTitle("Move to TODO", for: .normal)
            popoverSecondButton.setTitle("Move to DOING", for: .normal)
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
