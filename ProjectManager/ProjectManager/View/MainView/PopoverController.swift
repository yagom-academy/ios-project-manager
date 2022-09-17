//
//  PopoverController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import UIKit

final class PopoverController: UIViewController, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray4
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )

        return stackView
    }()

    private let firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()

    private let secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        configureUI()
    }

    private func configureUI() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setTitle(firstButtonName: String, secondButtonName: String) {
        firstButton.setTitle("Move to \(firstButtonName)", for: .normal)
        secondButton.setTitle("Move to \(secondButtonName)", for: .normal)
    }
}
