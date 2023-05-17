//
//  TaskHeaderView.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/18.
//

import UIKit

final class TaskHeaderView: UICollectionReusableView {
    
    private let titleLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    private let contentsInfoLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .black
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 25 / 2
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
extension TaskHeaderView {
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentsInfoLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
