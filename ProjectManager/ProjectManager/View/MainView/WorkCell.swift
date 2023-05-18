//
//  WorkCell.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import UIKit

final class WorkCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, body: String, deadline: String) {
        titleLabel.text = title
        bodyLabel.text = body
        deadlineLabel.text = deadline
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }
    
    private func configureLayout() {
        let stackView = createStackView()
        
        contentView.addSubview(stackView)
        contentView.addSubview(deadlineLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            deadlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            deadlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deadlineLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
        ])
    }
}
