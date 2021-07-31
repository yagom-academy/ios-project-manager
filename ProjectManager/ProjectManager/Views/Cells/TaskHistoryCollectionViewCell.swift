//
//  TaskHistoryCollectionViewCell.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/31.
//

import UIKit

final class TaskHistoryCollecionViewCell: UICollectionViewCell {
    static let identifier = "TaskCollectionViewCell"
    
    private let histortTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let histortDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        setHistoryTitleConstraint()
        setHistoryDateConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setHistoryTitleConstraint() {
        self.addSubview(histortTitle)
        NSLayoutConstraint.activate([
            self.histortTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.histortTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.histortTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
        ])
    }
    
    private func setHistoryDateConstraint() {
        self.addSubview(histortDate)
        NSLayoutConstraint.activate([
            self.histortDate.leadingAnchor.constraint(equalTo: self.histortTitle.leadingAnchor),
            self.histortDate.topAnchor.constraint(equalTo: self.histortTitle.topAnchor, constant: 3),
            self.histortDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
        ])
    }
    
    private func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm:ss a"
        return dateFormatter.string(from: date)
    }
    
    func configureCell() {
        self.histortTitle.text = "asdqiowmdqmdqkdq"
        self.histortDate.text = "MAY 28, 2021 3:53:32 PM"
    }
    
}
