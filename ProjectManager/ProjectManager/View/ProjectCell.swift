//
//  ProjectManager - ProjectCell.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class ProjectCell: UICollectionViewCell {
    let identifier = "ProjectCell"
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    func configureContent(title: String, body: String, date: String) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentStackView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentStackView() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
