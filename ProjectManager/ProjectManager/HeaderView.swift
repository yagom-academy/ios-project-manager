//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Wonbi on 2023/01/12.
//

import UIKit

final class HeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: CountLabel = {
        let countLabel = CountLabel()
        countLabel.text = "1,000"
        countLabel.textAlignment = .center
        countLabel.textColor = .white
        countLabel.backgroundColor = .black
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        titleLabel.text = title
        
        addSubview(titleLabel)
        addSubview(countLabel)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.8),
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: titleLabel.heightAnchor, multiplier: 0.8)
        ])
    }
}
