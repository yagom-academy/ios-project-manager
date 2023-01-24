//
//  TaskCell.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class TaskCell: UITableViewCell {
    
    private var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    private var taskExpirationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(with data: Task) {
        taskTitleLabel.text = data.title
        taskDescriptionLabel.text = data.description
        taskExpirationLabel.text = data.expireDate.description
    }
    
    private func layout() {
        wholeStackView.addArrangedSubview(taskTitleLabel)
        wholeStackView.addArrangedSubview(taskDescriptionLabel)
        wholeStackView.addArrangedSubview(taskExpirationLabel)
        self.contentView.addSubview(wholeStackView)
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            wholeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            wholeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            wholeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskTitleLabel.text = nil
        taskDescriptionLabel.text = nil
        taskExpirationLabel.text = nil
    }
}
