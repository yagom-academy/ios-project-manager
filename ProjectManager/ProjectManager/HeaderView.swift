//
//  HeaderView.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/17.
//

import UIKit

final class TodoHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "headerView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCountLabel(todoCount: Int) {
        let todoCountString = String(todoCount)
        
        countLabel.text = "4"
    }
    
    private func configureUI() {
        self.backgroundColor = .lightGray
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20)
        ])
    }
}
