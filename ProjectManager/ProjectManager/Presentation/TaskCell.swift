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
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    private var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .systemGray3
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
        stack.spacing = 3
        return stack
    }()
    
    var viewModel: TaskItemViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskCell {
    func setupUsingViewModel() {
        guard let viewModel = self.viewModel else { return }
        taskTitleLabel.text = viewModel.title
        taskDescriptionLabel.text = viewModel.description
        
        if viewModel.date <= Date() {
            taskExpirationLabel.attributedText = viewModel.date.expired()
            return
        }
        
        taskExpirationLabel.text = viewModel.date.converted()
    }
    
    private func layout() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        self.wholeStackView.backgroundColor = .white
        self.wholeStackView.addArrangedSubview(taskTitleLabel)
        self.wholeStackView.addArrangedSubview(taskDescriptionLabel)
        self.wholeStackView.addArrangedSubview(taskExpirationLabel)
        self.contentView.addSubview(wholeStackView)
        
        NSLayoutConstraint.activate([
            self.wholeStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                     constant: 8),
            self.wholeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                        constant: -8),
            self.wholeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                         constant: 8),
            self.wholeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                          constant: -8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskTitleLabel.text = nil
        taskDescriptionLabel.text = nil
        taskExpirationLabel.text = nil
    }
}
