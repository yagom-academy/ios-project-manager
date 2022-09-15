//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/07.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let identifier = "CustumCell"
    
    // MARK: - properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = .systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .footnote)
        
        return label
    }()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - functions

extension TodoTableViewCell {
    func setupDataSource(project: Project) {
        titleLabel.text = project.title
        descriptionLabel.text = project.description
        dateLabel.text = project.date.dateString()
        if isCheckDate(project.date) {
            dateLabel.textColor = .systemRed
        }
    }
    
    private func isCheckDate(_ date: Date) -> Bool {
        return date < Date()
    }
    
    private func setupConstraints() {
        contentView.addSubview(listStackView)
        
        listStackView.addArrangedSubview(titleLabel)
        listStackView.addArrangedSubview(descriptionLabel)
        listStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            listStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            listStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            listStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            listStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
}
