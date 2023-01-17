//
//  ListCell.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

class ListCell: UICollectionViewListCell, ReusableCell {

    typealias Style = Constant.Style
    typealias Color = Constant.Color

    private let titleLabel = UILabel()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = Color.descriptionLabel

        return label
    }()
    private let deadlineLabel = UILabel()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, deadlineLabel, deadlineLabel])
        stackView.axis = .vertical
        stackView.spacing = Style.listCellSpacing
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    func configure(title: String, description: String, deadline: String, isOverDue: Bool) {
        backgroundColor = Color.cellBackground
        configureViewHierarchy()
        configureLayoutConstraint()
        setTexts(title: title, description: description, deadline: deadline)
        setDeadlineColor(isOverDue: isOverDue)
    }

    private func configureViewHierarchy() {
        addSubview(stackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Style.listCellSpacing),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style.listCellSpacing),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Style.listCellSpacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Style.listCellSpacing),
        ])
    }

    private func setTexts(title: String, description: String, deadline: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        deadlineLabel.text = deadline
    }

    private func setDeadlineColor(isOverDue: Bool) {
        if isOverDue {
            deadlineLabel.textColor = Color.overDue
        }
    }
}
