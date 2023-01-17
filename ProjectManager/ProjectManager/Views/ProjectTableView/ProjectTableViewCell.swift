//
//  ProjectTableViewCell.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/13.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {
    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .caption1)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    private let dueDateLabel: UILabel = {
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

    // MARK: Initialization
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        configureView()
    }

    // MARK: Private Method
    private func configureView() {
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dueDateLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    // MARK: Internal Method
    func configure(with project: Project) {
        titleLabel.text = project.title
        descriptionLabel.text = project.description
        dueDateLabel.text = project.dueDate.localizedString
    }
}

// MARK: Reusable 프로토콜 채택
extension ProjectTableViewCell: Reusable { }
