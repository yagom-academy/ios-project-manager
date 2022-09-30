//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import UIKit

final class TodoListCell: UITableViewCell {
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        return titleLabel
    }()
    
    private let bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        bodyLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.numberOfLines = 3
        bodyLabel.lineBreakMode = .byTruncatingTail
        
        return bodyLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        dateLabel.adjustsFontForContentSizeCategory = true
        return dateLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
}

extension TodoListCell: ReuseIdentifying {
    private func commonInit() {
        addSubView()
        setupConstraint()
    }
    
    private func addSubView() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        self.contentView.addSubview(verticalStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(todoData: TodoModel) {
        self.titleLabel.text = todoData.title
        self.bodyLabel.text = todoData.body
        self.dateLabel.text = todoData.createdAt.formatted()
    }
}
