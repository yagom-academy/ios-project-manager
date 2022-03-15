//
//  MainTableViewHeaderView.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/05.
//

import UIKit

class MainTableViewHeaderView: UITableViewHeaderFooterView {

// MARK: - View Component

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = HeaderViewConstraints.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let taskLabel: UILabel = {
        let label = UILabel()
        label.font = HeaderViewFont.taskLabel

        return label
    }()

    private let todoCountLabel: UILabel = {
        let label = UILabel()
        label.circleBadge(
            count: HeaderViewConstraints.defaultCount,
            size: HeaderViewConstraints.circleWidth
        )
        label.font = HeaderViewFont.todoCountLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return view
    }()

// MARK: - Initialization

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.configureHierarchy()
        self.configureStackViewConstraints()
        self.configureTodoCountLabel()
    }

// MARK: - Configure Contents

    func configureContents(todoCount: Int, withTitle title: String) {
        self.taskLabel.text = title
        self.todoCountLabel.text = String(todoCount)
    }

// MARK: - Configure View

    private func configureHierarchy() {
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.taskLabel)
        self.stackView.addArrangedSubview(self.todoCountLabel)
        self.stackView.addArrangedSubview(self.spacerView)
    }

// MARK: - Configure Constraints

    private func configureStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: HeaderViewConstraints.stackViewPadding
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -(HeaderViewConstraints.stackViewPadding)
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: HeaderViewConstraints.stackViewLeadingPadding
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -(HeaderViewConstraints.stackViewPadding)
            )
        ])
    }

    private func configureTodoCountLabel() {
        NSLayoutConstraint.activate([
            self.todoCountLabel.widthAnchor.constraint(
                equalToConstant: HeaderViewConstraints.circleWidth
            ),
            self.todoCountLabel.heightAnchor.constraint(
                equalToConstant: HeaderViewConstraints.circleWidth
            )
        ])
    }
}

private enum HeaderViewConstraints {

    static let circleWidth: CGFloat = 20
    static let spacing: CGFloat = 8
    static let defaultCount = 0
    static let stackViewPadding: CGFloat = 4
    static let stackViewLeadingPadding: CGFloat = 10
}

private enum HeaderViewFont {

    static let taskLabel = UIFont.preferredFont(for: .title3, weight: .regular)
    static let todoCountLabel = UIFont.preferredFont(for: .body, weight: .light)
}
