//
//  TaskListHeaderView.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

import UIKit

class TaskListHeaderView: UICollectionReusableView, IdentifierType {
    let label = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
