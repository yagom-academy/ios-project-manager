//
//  TaskTableViewCell.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/03.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TaskTableViewCell"

    private let dateFormatter = DateFormatter()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "placeholder Title"
        return label
    }()

    private let contextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "placeholder Context"
        return label
    }()

    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "placeholder Deadline"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setLabels()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contextLabel)
        contentView.addSubview(deadlineLabel)

        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            label.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }

        contextLabel.snp.makeConstraints { label in
            label.top.equalTo(titleLabel.snp.bottom).offset(5)
            label.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }

        deadlineLabel.snp.makeConstraints { label in
            label.top.equalTo(contextLabel.snp.bottom).offset(5)
            label.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }

    func setLabelText(title: String, context: String, deadline: Date) {
        titleLabel.text = title
        contextLabel.text = context
        deadlineLabel.text = dateToString(date: deadline)
    }
}

// MARK: - DateFormatter
extension TaskTableViewCell {
    func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}
