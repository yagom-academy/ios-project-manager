//
//  TaskCell.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class TaskCell: UITableViewCell {
    
    // MARK: View
    
    private let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .systemGray3
        
        return label
    }()
    private let taskExpirationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 3
        
        return stack
    }()
    
    // MARK: ViewModel
    
    var viewModel: TaskItemViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        combineViews()
        configureViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Function

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
}

// MARK: Layout

extension TaskCell {
    
    private func combineViews() {
        wholeStackView.backgroundColor = .white
        wholeStackView.addArrangedSubview(taskTitleLabel)
        wholeStackView.addArrangedSubview(taskDescriptionLabel)
        wholeStackView.addArrangedSubview(taskExpirationLabel)
        contentView.addSubview(wholeStackView)
    }
    
    private func configureViewsConstraints() {
        let contentViewInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame.inset(by: contentViewInset)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            wholeStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),
            wholeStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            wholeStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskTitleLabel.text = nil
        taskDescriptionLabel.text = nil
        taskExpirationLabel.text = nil
        taskExpirationLabel.attributedText = nil
        viewModel = nil
    }
}

private extension Date {
    
    func converted() -> String {
        return createTaskCellDateFormatter().string(from: self)
    }
    
    func expired() -> NSAttributedString {
        let string = createTaskCellDateFormatter().string(from: self)
        let range = NSRange(location: 0, length: string.count)
        let mutableString = NSMutableAttributedString(string: string)
        mutableString.setAttributes([.foregroundColor: UIColor.systemRed], range: range)
        
        return mutableString
    }
    
    private func createTaskCellDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMMdd")
        return dateFormatter
    }
}
