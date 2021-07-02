//
//  ProjectManagerTableViewCell.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class ProjectManagerTableViewCell: UITableViewCell {
    
    static let identifier = "ProjectManagerTableViewCell"
    let projectManagerCellStackView = ProjectManagerCellStackView()

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
        addSubview(projectManagerCellStackView)
        
        NSLayoutConstraint.activate([
            projectManagerCellStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            projectManagerCellStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            projectManagerCellStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            projectManagerCellStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func configureLabel() {
        projectManagerCellStackView.addArrangedSubview(titleLabel)
        projectManagerCellStackView.addArrangedSubview(descriptionLabel)
        projectManagerCellStackView.addArrangedSubview(dateLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        titleLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 3
        dateLabel.numberOfLines = 1
        
        descriptionLabel.lineBreakMode = .byTruncatingTail
        dateLabel.textColor = .systemRed
    }
}

