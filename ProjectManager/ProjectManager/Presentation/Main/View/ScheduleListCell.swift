//
//  ScheduleListCell.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import UIKit

final class ScheduleListCell: UITableViewCell {

// MARK: - Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .white
        stackView.weakShadow()
        return stackView
    }()

    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        label.numberOfLines = 3
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()

// MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

// MARK: - Methods

    func configureContent(with item: Schedule) {
        self.titleLabel.text = item.title
        self.bodyLabel.text = item.body
        self.dateLabel.text = item.dueDate.formattedDateString
        self.dateLabel.textColor = dateLabelColor(for: item.dueDate)
    }
}

// MARK: - Private Methods

extension ScheduleListCell {

    private func commonInit() {
        self.backgroundColor = .clear
        self.configureHierarchy()
        self.configureConstraint()
    }

    private func configureHierarchy() {
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.bodyLabel)
        self.dateStackView.addArrangedSubview(self.dateLabel)
        self.stackView.addArrangedSubview(self.dateStackView)
    }

    private func configureConstraint() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    private func dateLabelColor(for date: Date) -> UIColor {
        let outDated = Calendar.autoupdatingCurrent
            .compare(Date(), to: date, toGranularity: .day) == .orderedDescending

        return outDated ? .systemRed : .black
    }
}
