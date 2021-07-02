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
        super.init(style: .default, reuseIdentifier: ProjectManagerTableViewCell.identifier)
        configureCellStackView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCellStackView() {
        addSubview(projectManagerCellStackView)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectManagerCellStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            projectManagerCellStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            projectManagerCellStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            projectManagerCellStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
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
        
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
}

