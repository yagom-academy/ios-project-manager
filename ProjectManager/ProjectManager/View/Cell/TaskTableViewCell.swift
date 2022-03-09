//
//  TaskTableViewCell.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/09.
//

import UIKit

private enum Design {
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let topMargin: CGFloat = 10
    static let bottomMargin: CGFloat = -10
}

class TaskTableViewCell: UITableViewCell {
    let taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        [titleLabel, descriptionLabel, deadlineLabel].forEach {
            taskStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(taskStackView)
        
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.topMargin),
            taskStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.leadingMargin),
            taskStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Design.trailingMargin),
            taskStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Design.bottomMargin)
        ])
    }
    
    func configureCell(title: String, description: String, deadline: Date) {
        titleLabel.text = title
        descriptionLabel.text = description
        deadlineLabel.text = deadline.description
    }
}
