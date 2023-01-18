//
//  MainTitleView.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/13.
//

import UIKit

class MainTitleView: UIView {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NameSpace.projectManagerTitle
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    
    override func draw(_ rect: CGRect) {
        configureLayout()
    }
    
    // MARK: Private Methods

    private func configureLayout() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
