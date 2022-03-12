//
//  ScheduleListCell.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import UIKit

private enum Design {
    static let cellBackgroundColor = UIColor.clear
    static let stackViewSpacing = 2.0
    static let stackViewLayoutMargins = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
    static let stackViewTopAnchorConstant = 0.8
    static let titleLabelFont = UIFont.preferredFont(forTextStyle: .body)
    static let bodyLabelFont = UIFont.preferredFont(forTextStyle: .footnote)
    static let bodyLabelNumberOfLines = 3
    static let bodyLabelColor = UIColor.systemGray
    static let dateLabelFont = UIFont.preferredFont(forTextStyle: .caption2)
    static let dateViewLayoutMargins = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
    static let dateLabelColor = UIColor.black
    static let dateLabelColorWhenOutdated = UIColor.systemRed
}

final class ScheduleListCell: UITableViewCell {

// MARK: - Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Design.stackViewSpacing
        stackView.layoutMargins = Design.stackViewLayoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .white
        stackView.weakShadow()
        return stackView
    }()

    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = Design.stackViewLayoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.titleLabelFont
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = Design.bodyLabelFont
        label.textColor = Design.bodyLabelColor
        label.numberOfLines = Design.bodyLabelNumberOfLines
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Design.dateLabelFont
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
        self.dateLabel.textColor = self.dateLabelColor(for: item.dueDate)
    }
}

// MARK: - Private Methods

extension ScheduleListCell {

    private func commonInit() {
        self.backgroundColor = Design.cellBackgroundColor
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
            self.stackView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: Design.stackViewTopAnchorConstant
            ),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    private func dateLabelColor(for date: Date) -> UIColor {
        let outDated = Calendar.autoupdatingCurrent
            .compare(Date(), to: date, toGranularity: .day) == .orderedDescending

        return outDated ? Design.dateLabelColorWhenOutdated : Design.dateLabelColor
    }
}
