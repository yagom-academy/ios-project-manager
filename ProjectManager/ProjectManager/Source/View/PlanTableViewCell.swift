//
//  PlanTableViewCell.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

final class PlanTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = LayoutConstraint.titleLine
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = LayoutConstraint.descriptionLines
        label.font = .preferredFont(forTextStyle: .caption1)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLayout()
    }

    func configureCell(with todo: Plan) {
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.description
        self.deadlineLabel.text = DateFormatterManager.formatDate(todo.deadline)

        guard let validate = DateFormatterManager.isExpiredDate(todo.deadline) else { return }

        deadlineLabel.textColor = validate ? .red : .black
    }

    private func configureLayout() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(deadlineLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstraint.topConstant),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstraint.bottomConstant),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstraint.leadingConstant),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstraint.trailingConstant)
        ])
    }

    private enum LayoutConstraint {
        static let spacing: CGFloat = 4
        static let titleLine: Int = 1
        static let descriptionLines: Int = 3
        static let topConstant: CGFloat = 8
        static let bottomConstant: CGFloat = -8
        static let leadingConstant: CGFloat = 20
        static let trailingConstant: CGFloat = -20
    }
}

