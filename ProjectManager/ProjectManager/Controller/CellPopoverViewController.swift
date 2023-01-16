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
        button.backgroundColor = .brown
        button.setTitle("Move to DOING", for: .normal)
        return button
    }()

    private let secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brown
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4
        view.addSubview(verticalStackView)
        firstButton.addTarget(self, action: #selector(touchUpFirstButton(_:)), for: .touchUpInside)
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
}

// MARK: - Objc
extension CellPopoverViewController {
    @objc private func touchUpFirstButton(_ sender: UIButton) {
        print("asdf")
        dismiss(animated: true)
    }

    @objc private func touchUpSecondButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
