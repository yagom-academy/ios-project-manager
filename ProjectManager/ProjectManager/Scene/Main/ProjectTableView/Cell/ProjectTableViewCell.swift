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
    
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Functions
    
    func configure(data: ToDoItem, type: ProjectType) {
        titleLabel.text = data.title
        descriptionLabel.text = data.toDoDescription
        timeLimitLabel.text = data.timeLimit.formatDate()
        
        guard type != .done else { return }
        setuptimeLimitLabelColor(data)
    }
    
    private func setuptimeLimitLabelColor(_ data: ToDoItem) {
        guard data.timeLimit < Date() else {
            timeLimitLabel.textColor = .black
            return
        }
        timeLimitLabel.textColor = .red
    }
    
    private func commonInit() {
        setupSubviews()
        setupVerticalStackViewLayout()
    }
    
    private func setupSubviews() {
        [verticalStackView, emptyView]
            .forEach { contentView.addSubview($0) }
        
        [titleLabel, descriptionLabel, timeLimitLabel]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
 
    private func setupVerticalStackViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            emptyView.heightAnchor.constraint(equalToConstant: 12),
            emptyView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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
