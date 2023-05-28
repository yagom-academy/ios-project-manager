//
//  ProjectManager - ProjectCell.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class ProjectCell: UITableViewCell {
    let identifier = "ProjectCell"
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentStackView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(title: String, body: String, date: String) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
    }
    
    func changeDateColor(isOverdue: Bool) {
        if isOverdue {
            dateLabel.textColor = .systemRed
        } else {
            dateLabel.textColor = .black
        }
    }
    
    private func configureContentStackView() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
