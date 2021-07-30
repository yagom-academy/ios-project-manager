//
//  TaskCell.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import UIKit

final class TaskCell: UITableViewCell {

    private enum Style {
        static let inset: CGFloat = 8
        static let spacing: CGFloat = 3

        static let titleTextStyle: UIFont.TextStyle = .headline
        static let titleLineLimit: Int = 1

        static let bodyTextColor: UIColor = .systemGray
        static let bodyTextStyle: UIFont.TextStyle = .subheadline
        static let bodyLineLimit: Int = 3

        static let dueDateTextColor: UIColor = .label
        static let expiredDateTextColor: UIColor = .systemRed
        static let dueDateTextStyle: UIFont.TextStyle = .caption1
        static let dueDateLineLimit: Int = 1
    }

    // MARK: Properties

    static let reuseIdentifier = "TaskCell"

    // MARK: Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: Style.titleTextStyle)
        label.numberOfLines = Style.titleLineLimit
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: Style.bodyTextStyle)
        label.numberOfLines = Style.bodyLineLimit
        label.textColor = Style.bodyTextColor
        return label
    }()

    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: Style.dueDateTextStyle)
        label.numberOfLines = Style.dueDateLineLimit
        return label
    }()

    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Style.spacing
        return stackView
    }()

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configure

    override func prepareForReuse() {
        titleLabel.text = nil
        bodyLabel.text = nil
        dueDateLabel.text = nil
        dueDateLabel.textColor = nil
    }

    func configure(with task: Task?) {
        titleLabel.text = task?.title
        bodyLabel.text = task?.body
        dueDateLabel.text = task?.dueDate.taskFormat
        setStyle(with: task)
    }

    private func setSubviews() {
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dueDateLabel)

        contentView.addSubview(contentStackView)
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style.inset),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Style.inset),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Style.inset),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Style.inset)
        ])
    }

    private func setStyle(with task: Task?) {
        guard let task = task,
              let date = Date().date else { return }

        dueDateLabel.textColor = (task.dueDate >= date) ? Style.dueDateTextColor : Style.expiredDateTextColor
    }
}
