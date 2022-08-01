//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import UIKit

final class HistoryCell: UITableViewCell {
    private let actionLabel = UILabel()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCell()
        self.setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpCell() {
        self.backgroundColor = .systemGray5
        self.contentView.backgroundColor = .systemBackground
    }

    private func setUpConstraints() {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.historyStackView)
        self.contentView.addSubview(self.dateLabel)
        self.historyStackView.addArrangedSubviews(with: [self.actionLabel, self.titleLabel, self.statusLabel])

        NSLayoutConstraint.activate([
            self.historyStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.historyStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -5),
            self.historyStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.historyStackView.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }

    func configure(_ history: History) {
        self.actionLabel.text = history.action.description
        self.titleLabel.text = history.title
        self.statusLabel.text = history.status
        self.dateLabel.text = history.date
    }
}
