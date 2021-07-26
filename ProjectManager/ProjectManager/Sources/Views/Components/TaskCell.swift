//
//  TaskCell.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import UIKit

final class TaskCell: UITableViewCell {

    // MARK: Properties

    static let reuseIdentifier = "TaskCell"

    // MARK: Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.gray
        label.numberOfLines = 3
        return label
    }()

    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 1
        return label
    }()

    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configure

    func configure(with task: Task?) {
        titleLabel.text = task?.title
        bodyLabel.text = task?.body
        dueDateLabel.text = task?.dueDate.formatted
        setStyle(with: task)
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setSubviews() {
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dueDateLabel)
        contentView.addSubview(contentStackView)
    }

    private func setStyle(with task: Task?) {
        guard let task = task,
              let date = Date().date else { return }
        dueDateLabel.textColor = (task.dueDate >= date) ? UIColor.label : UIColor.systemRed
    }
}
