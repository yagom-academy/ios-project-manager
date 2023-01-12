//
//  ListItemCell.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListItemCell: UITableViewCell {
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        
        return label
    }()
    private let listBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        label.textColor = .systemGray4
        label.numberOfLines = 3
        
        return label
    }()
    private let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        
        return label
    }()
    
    convenience init(title: String, body: String, dueDate: String) {
        self.init(frame: .zero)
        
        configureLayout()
        listTitleLabel.text = title
        listBodyLabel.text = body
        dueDateLabel.text = dueDate
    }
    
    private func configureLayout() {
        contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
