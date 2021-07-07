//
//  ProjectManagerTableViewCell.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    static let identifier = "ProjectManagerTableViewCell"
    let cellStackView = CellStackView()

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellStackView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCellStackView() {
        addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func configureLabel() {
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(descriptionLabel)
        cellStackView.addArrangedSubview(dateLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        titleLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 3
        dateLabel.numberOfLines = 1
        
        descriptionLabel.lineBreakMode = .byTruncatingTail
    }
}

