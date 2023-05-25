//
//  TaskListCell.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/17.
//

import UIKit

final class TaskListCell: UICollectionViewListCell {
    
    static let identifier = "TaskTableViewCell"
    
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
    private let deadlineDateLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        deadlineDateLabel.text = nil
    }
    
    func updateText(by task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        deadlineDateLabel.text = task.date.formattedText
        deadlineDateLabel.textColor = calculateDateLabelText(task)
    }
    
    private func calculateDateLabelText(_ task: Task) -> UIColor {
        guard task.state != .done else { return .label }
        
        let nowDate = Date().formattedText
        
        if task.date.formattedText >= nowDate {
            return .label
        } else {
            return .systemRed
        }
    }
}

// MARK: UI
extension TaskListCell {
    private func configureUI() {
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, deadlineDateLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 2
        mainStackView.setCustomSpacing(4, after: descriptionLabel)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
