//
//  HistoryListCell.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/27.
//

import UIKit
import OSLog

final class HistoryListCell: UITableViewCell, ReusableCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        os_log(.default, log: .ui, "Didn't use nib File")
    }

    func setContent(description: String, date: String?) {
        descriptionLabel.text = description
        dateLabel.text = date
    }
    
    private func configureUI() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: inset),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -inset),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset)
        ])
    }
}
