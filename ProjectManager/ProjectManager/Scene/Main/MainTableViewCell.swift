//
//  MainTableViewCell.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

class MainTableViewCell: UITableViewCell {

// MARK: - View Components

    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CellConstraint.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: CellFont.titleSize)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left

        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: CellFont.defaultSize)
        label.textColor = CellColor.content
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.numberOfLines = CellConstant.numberOfLineForDynamicHeight

        let dynamicSize = label.sizeThatFits(
            CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude)
        )
        label.frame.size.height = dynamicSize.height

        return label
    }()

    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: CellFont.deadlineSize)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left

        return label
    }()

// MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.configureHierarchy()
        self.configureConstraints()
    }

// MARK: - Configure Contents

    func configureTodo(for todo: Todo) {
        let today = Date()
        let deadline = todo.deadline?.date ?? today
        let date = DateFormatter.deadlineFormat.string(from: deadline)

        if deadline < today {
            self.deadlineLabel.textColor = .systemRed
        } else if deadline == today {
            self.deadlineLabel.textColor = .systemBlue
        }

        self.titleLabel.text = todo.title
        self.contentLabel.text = todo.content
        self.deadlineLabel.text = date
    }

// MARK: - Configure View

    private func configureHierarchy() {
        self.contentView.addSubview(self.cellStackView)
        self.cellStackView.addArrangedSubview(self.titleLabel)
        self.cellStackView.addArrangedSubview(self.contentLabel)
        self.cellStackView.addArrangedSubview(self.deadlineLabel)
    }

// MARK: - Configure Constraints

    private func configureConstraints() {
        self.stackViewConstraints()
        self.titleLabelConstraints()
        self.contentLabelConstraints()
        self.deadlineLabelConstraints()
    }

    private func stackViewConstraints() {
        NSLayoutConstraint.activate([
            self.cellStackView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: CellConstraint.cellStackViewPadding
            ),
            self.cellStackView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -(CellConstraint.cellStackViewPadding)
            ),
            self.cellStackView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: CellConstraint.cellStackViewPadding
            ),
            self.cellStackView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -(CellConstraint.cellStackViewPadding)
            )
        ])
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.cellStackView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(
                equalTo: self.cellStackView.topAnchor,
                constant: CellConstraint.defaultFontHeight
            ),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.cellStackView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.cellStackView.trailingAnchor)
        ])
    }

    private func contentLabelConstraints() {
        NSLayoutConstraint.activate([
            self.contentLabel.topAnchor.constraint(
                equalTo: self.cellStackView.topAnchor,
                constant: CellConstraint.defaultFontHeight + CellConstraint.spacing
            ),
            self.contentLabel.bottomAnchor.constraint(
                equalTo: self.cellStackView.bottomAnchor,
                constant: -(CellConstraint.defaultFontHeight + CellConstraint.spacing)
            ),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.cellStackView.leadingAnchor),
            self.contentLabel.trailingAnchor.constraint(
                equalTo: self.cellStackView.trailingAnchor
            )
        ])
    }

    private func deadlineLabelConstraints() {
        NSLayoutConstraint.activate([
            self.deadlineLabel.topAnchor.constraint(
                equalTo: self.cellStackView.bottomAnchor,
                constant: -(CellConstraint.defaultFontHeight)
            ),
            self.deadlineLabel.bottomAnchor.constraint(equalTo: self.cellStackView.bottomAnchor),
            self.deadlineLabel.leadingAnchor.constraint(equalTo: self.cellStackView.leadingAnchor),
            self.deadlineLabel.trailingAnchor.constraint(
                equalTo: self.cellStackView.trailingAnchor
            )
        ])
    }
}

private enum CellConstraint {
    static let cellStackViewPadding: CGFloat = 15
    static let spacing: CGFloat = 5
    static let defaultFontHeight: CGFloat = 20
}

private enum CellFont {
    static let titleSize: UIFont.TextStyle = .headline
    static let defaultSize: UIFont.TextStyle = .callout
    static let deadlineSize: UIFont.TextStyle = .subheadline
}

private enum CellColor {
    static let content: UIColor = .systemGray3
}

private enum CellConstant {
    static let numberOfLineForDynamicHeight = 0
}
