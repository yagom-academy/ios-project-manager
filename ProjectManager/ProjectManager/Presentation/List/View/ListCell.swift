//
//  ListCell.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListCell: UITableViewCell, Reusable {

    typealias Style = Constant.Style
    typealias Color = Constant.Color

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)

        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = Color.descriptionLabel
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)

        return label
    }()
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)

        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, deadlineLabel])
        stackView.axis = .vertical
        stackView.spacing = Style.listCellSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Color.cellBackground
        backgroundColor = Color.listBackground
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
    }

    func configure(title: String, description: String, deadline: String, isOverDue: Bool = false) {
        setTexts(title: title, description: description, deadline: deadline)
        setDeadlineColor(isOverDue: isOverDue)
    }

    private func configureViewHierarchy() {
        contentView.addSubview(stackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: Style.listCellSpacing),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: Style.listCellSpacing),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -Style.listCellSpacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Style.listCellSpacing),
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
