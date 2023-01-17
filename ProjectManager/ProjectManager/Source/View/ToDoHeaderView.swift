//  ProjectManager - ToDoHeaderView.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoHeaderView: UIView {
    private let status: ToDoState
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = status.name
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var listCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "5"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(status: ToDoState) {
        self.status = status
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(listCountLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listCountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            listCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5)
        ])
    }
}
