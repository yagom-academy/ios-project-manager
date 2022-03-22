//
//  HistoryListCell.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import UIKit

private enum Design {
    static let cellBackgroundColor = UIColor.clear
    static let stackViewSpacing = 2.0
    static let stackViewLayoutMargins = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
    static let stackViewTopAnchorConstant = 8.0
    static let stackViewBackgroundColor = UIColor.white
    static let titleLabelFont = UIFont.preferredFont(forTextStyle: .body)
    static let dateLabelFont = UIFont.preferredFont(forTextStyle: .caption1)
    static let dateLabelColor = UIColor.systemGray
}

final class HistoryListCell: UITableViewCell {

// MARK: - Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Design.stackViewSpacing
        stackView.layoutMargins = Design.stackViewLayoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = Design.stackViewBackgroundColor
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.titleLabelFont
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Design.dateLabelFont
        label.textColor = Design.dateLabelColor
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

    func configureContent(with item: ScheduleAction) {
        self.titleLabel.text = item.type.description
        self.dateLabel.text = item.time.formattedHistoryDateString
    }
}

// MARK: - Private Methods

extension HistoryListCell {

    private func commonInit() {
        self.backgroundColor = Design.cellBackgroundColor
        self.configureHierarchy()
        self.configureConstraint()
    }

    private func configureHierarchy() {
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.dateLabel)
    }

    private func configureConstraint() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.stackView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: Design.stackViewTopAnchorConstant
            ),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
