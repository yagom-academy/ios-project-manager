//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell, Reusable {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, deadlineLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        backgroundColor = .systemGray5
        configureViewHierarchy()
        configureLayoutConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    func configure(title: String, description: String, deadline: String, isOverdue: Bool = false) {
        setTexts(title: title, description: description, deadline: deadline)
        setDeadlineColor(isOverDue: isOverdue)
    }
    
    private func configureViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -8),
        ])
    }
    
    private func setTexts(title: String, description: String, deadline: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        deadlineLabel.text = deadline
    }
    
    private func setDeadlineColor(isOverDue: Bool) {
        deadlineLabel.textColor = isOverDue ? .systemRed : .label
    }
}
