//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import UIKit

final class TodoListCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCell()
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        self.contentView.addSubview(self.contentsStackView)
        self.contentView.addSubview(self.dateLabel)
    }
    
    private func setUpLayout() {
        self.contentsStackView.addArrangedSubviews(with: [titleLabel, descriptionLabel])
        
        NSLayoutConstraint.activate([
            self.contentsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.contentsStackView.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func configure(_ todo: Todo) {
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.description
        self.dateLabel.text = todo.date
    }
}
