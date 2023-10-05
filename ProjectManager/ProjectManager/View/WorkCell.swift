//
//  WorkCell.swift
//  ProjectManager
//
//  Created by BMO on 2023/09/25.
//

import UIKit

final class WorkCell: UITableViewCell {
    static let identifier: String = "WorkCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .gray
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    private func setUI() {
        separatorInset = UIEdgeInsets.zero
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(deadlineLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func config(title: String, description: String, deadline: Date) {
        titleLabel.text = title
        descriptionLabel.text = description
        deadlineLabel.text = deadline.description
    }
}
