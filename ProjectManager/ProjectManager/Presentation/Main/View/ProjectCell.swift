//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class ProjectCell: UITableViewCell {
    var contentID: UUID?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        return label
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "\(ProjectCell.self)")
        
        setUpCell()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        contentView.addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(titleLabel)
        baseStackView.addArrangedSubview(descriptionLabel)
        baseStackView.addArrangedSubview(deadlineLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            baseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func compose(content: ProjectContent) {
        guard let formattedDate = DateFormatter().formatted(string: content.deadline) else {
            return
        }
        
        contentID = content.id
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        deadlineLabel.text = content.deadline
        
        if formattedDate < Date() {
            deadlineLabel.textColor = .red
        }
    }
    
    override func prepareForReuse() {
        deadlineLabel.textColor = .black
        contentID = nil
    }
}
