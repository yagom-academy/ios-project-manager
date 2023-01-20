//
//  TaskCell.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/20.
//

import UIKit

final class TaskCell: UITableViewCell, ReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 3
        
        return label
    }()
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        contentLabel.text = task.content
        deadLineLabel.text = task.deadLine.toDateString
        deadLineLabel.textColor = task.isExpired ? .red : .black
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        contentLabel.text = nil
        deadLineLabel.text = nil
        deadLineLabel.textColor = .clear
    }
}

private extension TaskCell {
    func setUI() {
        let spacing: CGFloat = 8
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        stackView.addArrangedSubview(deadLineLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -spacing),
        ])
    }
}
