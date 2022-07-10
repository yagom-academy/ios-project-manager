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
        stackView.spacing = 5
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
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    private func setUpCell() {
        self.contentView.addSubview(self.contentsStackView)
        self.contentsStackView.addArrangedSubviews(with: [self.titleLabel, self.descriptionLabel, self.dateLabel])
        
        self.backgroundColor = .systemGray5
        self.contentView.backgroundColor = .systemBackground
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            self.contentsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.contentsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.contentsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.contentsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(_ todo: Todo) {
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.description
        self.dateLabel.text = todo.date.convertToString()
    }
}
