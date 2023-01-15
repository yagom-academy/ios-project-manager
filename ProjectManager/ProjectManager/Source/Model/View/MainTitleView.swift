//
//  MainTitleView.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/13.
//

import UIKit

class MainTitleView: UIView {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Project Manager"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    
    override func draw(_ rect: CGRect) {
        //        setUpPlusButtonAction()
        configureLayout()
    }
    
    // MARK: Private Methods

    private func configureLayout() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
