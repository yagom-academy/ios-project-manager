//
//  ProjectTableViewCell.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/13.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {
    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .systemGray
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    private let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        configureView()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Method
    private func configureView() {
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dueDateLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    // MARK: Internal Method
    func configure(with project: Project) {
        if project.isDueDateExpired {
            dueDateLabel.textColor = .systemRed
        } else {
            dueDateLabel.textColor = .black
        }

        titleLabel.text = project.title
        descriptionLabel.text = project.description
        dueDateLabel.text = project.dueDate.convertToString(format: "yyyy.MM.dd")
    }
}
