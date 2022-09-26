//
//  TodoListTableViewCell.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "Default Title"
        
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.text = "Default Body"
        
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Date().formattedDate
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Methods

extension TodoListTableViewCell {
    private func configureHierarchy() {
        contentView.addSubview(separatorView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(createdAtLabel)
    }
    
    private func configureLayout() {
        let separatorRect = CGRect(
            x: 0,
            y: 0,
            width: bounds.width * 10,
            height: 10
        )
        separatorView.frame = separatorRect
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: separatorView.bottomAnchor,
                constant: 15
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -15
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 15
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -15
            )
        ])
    }
}

// MARK: - Setter Methods

extension TodoListTableViewCell {
    func set(by todo: Todo) {
        titleLabel.text = todo.title
        bodyLabel.text = todo.body
        createdAtLabel.text = todo.createdAt.formattedDate
        createdAtLabel.textColor = todo.isOutdated ? .systemRed : .black
    }
}
