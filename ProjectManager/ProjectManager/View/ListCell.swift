//
//  ListCell.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import UIKit

final class ListCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .title3, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.numberOfLines = 3
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame
            .inset(by: UIEdgeInsets(
                top: 8,
                left: .zero,
                bottom: .zero,
                right: .zero)
            )
    }
    
    func setUpContent(_ todo: ToDo) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.body
        deadlineLabel.text = TodoDateFormatter.string(
            from: todo.deadline ?? Date(),
            format: DateFormat.todo
        )
    }
}

// MARK: - Configure UI
extension ListCell {
    private func configureUI() {
        addSubviews()
        setUpContentStackViewConstraints()
        setUpBackgroundColors()
    }
    
    private func addSubviews() {
        [titleLabel, descriptionLabel, deadlineLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(contentStackView)
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentStackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setUpBackgroundColors() {
        backgroundColor = .systemGray6
        contentView.backgroundColor = .systemBackground
    }
}
