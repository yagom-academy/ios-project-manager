//
//  MainTitleView.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/13.
//

import UIKit

class MainTitleView: UIView {
    
    // MARK: Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Project Manager"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    // MARK: Initializer
    
    override func draw(_ rect: CGRect) {
        configureLayout()
    }
    
    // MARK: Private Methods
    
    private func configureLayout() {
        addSubview(titleLabel)
        addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            plusButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
