//
//  TodoCell.swift
//  ProjectManager
//
//  Created by Sunwoo on 2022/03/04.
//

import UIKit

final class TodoCell: UITableViewCell {
    
    static let identifier = "TodoCell"
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray2
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let inset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: inset)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configureUI(todo: Todo) {
        configureBackgroundColor()
        configureStackViewLayout()
        configureTitleLabel(title: todo.title)
        configureBodyLabel(body: todo.body)
        configureDataLabel(deadline: todo.deadline)
    }
    
    private func configureBackgroundColor() {
        contentView.backgroundColor = .white
        backgroundColor = .systemGray6
    }
    
    private func configureStackViewLayout() {
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
    
    private func configureTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    private func configureBodyLabel(body: String) {
        bodyLabel.text = body
    }
    
    private func configureDataLabel(deadline: Date) {
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
