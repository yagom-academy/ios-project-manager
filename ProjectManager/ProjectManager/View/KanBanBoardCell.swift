//
//  KanBanBoardCell.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/19.
//

import UIKit

final class KanBanBoardCell: UITableViewCell {
    static let reuseIdentifier = "kanBanBoardCell"

    private let dateFormatter = DateFormatter()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    private let descriptionPreviewLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptionPreviewLabel"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "dateLabel"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionPreviewLabel)
        contentView.addSubview(dateLabel)

        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(contentView).inset(10)
            label.leading.equalTo(contentView).inset(10)
            label.trailing.equalTo(contentView).inset(10)
        }

        descriptionPreviewLabel.snp.makeConstraints { label in
            label.top.equalTo(titleLabel.snp.bottom).offset(10)
            label.leading.trailing.equalTo(contentView).inset(10)
        }

        dateLabel.snp.makeConstraints { label in
            label.top.equalTo(descriptionPreviewLabel.snp.bottom).offset(10)
            label.leading.equalTo(contentView).inset(10)
            label.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setText(title: String, description: String, date: Double) {
        self.titleLabel.text = title
        self.descriptionPreviewLabel.text = description
        self.dateLabel.text = convertDate(date: date)
        dateLabel.textColor = isDueDateOver(dueDate: date) ? .black : .systemRed
    }

    private func convertDate(date: Double) -> String {
        let result = Date(timeIntervalSince1970: date)

        self.dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        self.dateFormatter.dateStyle = .long

        return self.dateFormatter.string(from: result)
    }

    private func isDueDateOver(dueDate: Double) -> Bool {
        let currentDate = Date()
        let dueDate = Date(timeIntervalSince1970: dueDate)
        let comparisonResult = Calendar.current.compare(currentDate, to: dueDate, toGranularity: .day)

        return comparisonResult == .orderedAscending || comparisonResult == .orderedSame
    }
}
