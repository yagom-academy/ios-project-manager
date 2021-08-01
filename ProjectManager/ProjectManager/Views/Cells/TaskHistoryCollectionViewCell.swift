//
//  TaskHistoryCollectionViewCell.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/31.
//

import UIKit

final class TaskHistoryCollecionViewCell: UICollectionViewCell {
    static let identifier = "TaskHistoryCollectionViewCell"
    
    private let histortTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let histortDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var estimatedSize: CGSize = CGSize(width: 0, height: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHistoryTitleConstraint()
        setHistoryDateConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setHistoryTitleConstraint() {
        self.contentView.addSubview(self.histortTitle)
        NSLayoutConstraint.activate([
            self.histortTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.histortTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.histortTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
        ])
    }
    
    private func setHistoryDateConstraint() {
        self.contentView.addSubview(self.histortDate)
        NSLayoutConstraint.activate([
            self.histortDate.leadingAnchor.constraint(equalTo: self.histortTitle.leadingAnchor),
            self.histortDate.topAnchor.constraint(equalTo: self.histortTitle.bottomAnchor, constant: 5),
            self.histortDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.histortDate.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm:ss a"
        return dateFormatter.string(from: date)
    }
    
    func configureCell(data: TaskHistory) {
        self.histortTitle.text = data.title
        self.histortDate.text = convertDateToString(data.date)
    }
    
}
