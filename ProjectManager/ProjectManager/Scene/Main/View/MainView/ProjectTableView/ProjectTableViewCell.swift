//
//  ProjectTableViewCell.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Design.verticalStackViewSpacing
        
        return stackView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Design.titleLabelLine
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Design.descriptionLabelLine
        label.textColor = .lightGray
        
        return label
    }()
    
    private let timeLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Functions
    
    func configure(data: ToDoItem) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        timeLimitLabel.text = data.timeLimit.formatDate()
    }
    
    private func commonInit() {
        setupSubviews()
        setupVerticalStackViewLayout()
    }
    
    private func setupSubviews() {
        contentView.addSubview(verticalStackView)
        
        [titleLabel, descriptionLabel, timeLimitLabel]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
 
    private func setupVerticalStackViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let verticalStackViewSpacing: CGFloat = 5
        static let titleLabelLine = 1
        static let descriptionLabelLine = 3
    }
}

// MARK: - Extentions

extension ProjectTableViewCell: ReuseIdentifiable { }
