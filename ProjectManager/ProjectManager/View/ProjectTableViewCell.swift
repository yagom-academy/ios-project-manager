//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/07.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private var descpritionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.textAlignment = .left
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var deadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       descpritionLabel,
                                                       deadlineLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Intiailizer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        self.configureLayout()
    }
    
    // MARK: - Configure View
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: descpritionLabel.topAnchor, constant: 3),
            descpritionLabel.bottomAnchor.constraint(equalTo: deadlineLabel.topAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7)
        ])
    }
    
    func updateContent(title: String?,
                       description: String?,
                       deadline: String?,
                       with DeadlineTextColor: UIColor) {
        self.titleLabel.text = title
        self.descpritionLabel.text = description
        self.deadlineLabel.textColor = DeadlineTextColor
        self.deadlineLabel.text = deadline
    }
}
