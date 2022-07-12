//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit
import RxSwift

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
    
    private let dateLabel: UILabel = {
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
        baseStackView.addArrangedSubview(dateLabel)
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
        contentID = content.id
        
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        dateLabel.text = content.deadline
        
        guard let deadline = content.asProjectItem()?.deadline else {
            return
        }
        
        if deadline < Date() {
            dateLabel.textColor = .red
        }
    }
    
    override func prepareForReuse() {
        dateLabel.textColor = .black
    }
    
    func getData() -> ProjectContent? {
        guard let title = titleLabel.text,
              let date = dateLabel.text,
              let formattedDate = DateFormatter().formatted(string: date),
              let description = descriptionLabel.text else {
            return nil
        }
        
        return ProjectContent(
            title: title,
            deadline: formattedDate,
            description: description
        )
        contentID = nil
    }
}
