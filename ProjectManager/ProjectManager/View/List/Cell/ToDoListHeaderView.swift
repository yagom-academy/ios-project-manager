//
//  ToDoListHeaderView.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

class ToDoListHeaderView: UIView {
    private let status: ToDoStatus
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    let totalCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.backgroundColor = .black
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()

    init(_ status: ToDoStatus) {
        self.status = status
        super.init(frame: .init())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1)
        headerTitleLabel.text = status.rawValue
        self.addSubview(headerTitleLabel)
        self.addSubview(totalCountLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            headerTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            headerTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalCountLabel.leftAnchor.constraint(equalTo: headerTitleLabel.rightAnchor, constant: 5),
            totalCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupTotalCount(_ count: Int) {
        totalCountLabel.text = "\(count)"
    }
}

