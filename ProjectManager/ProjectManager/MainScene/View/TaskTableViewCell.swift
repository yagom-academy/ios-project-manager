//
//  TaskTableViewCell.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/17.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    private let titleLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    private let descriptionLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 3
        
        return label
    }()
    private let dateLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(by task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        dateLabel.text = task.date.description
    }
}

// MARK: UI
extension TaskTableViewCell {
    private func configureUI() {
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 2
        mainStackView.setCustomSpacing(4, after: descriptionLabel)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
