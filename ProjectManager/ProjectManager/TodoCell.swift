//
//  TodoCell.swift
//  ProjectManager
//
//  Created by Sunwoo on 2022/03/04.
//

import UIKit

class TodoCell: UITableViewCell {
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray2
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 3
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
    }
    
    func configureUI(todo: Todo) {
        configureStackViewLayout()
        configureTitleLabel(title: todo.title)
        configureBodyLabel(body: todo.body)
        configureDataLabel(deadline: todo.deadline)
        contentView.backgroundColor = .white
        backgroundColor = .systemGray6
    }
    
    func configureStackViewLayout() {
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(bodyLabel)
        labelStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configureTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func configureBodyLabel(body: String) {
        bodyLabel.text = body
    }
    
    func configureDataLabel(deadline: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        
        let deadlineTime = dateFormatter.string(from: deadline)
        let currentTime = dateFormatter.string(from: Date())
        
        dateLabel.text = deadlineTime
        dateLabel.textColor = deadlineTime < currentTime ? .red : .black
    }
}
