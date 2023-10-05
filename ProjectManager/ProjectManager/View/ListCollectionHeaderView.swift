//
//  ListCollectionHeaderView.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

final class ListCollectionHeaderView: UICollectionReusableView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let taskCountLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        return label
    }()
    
    private let dummyView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContents(title: String, taskCount: String) {
        titleLabel.text = title
        taskCountLabel.text = taskCount
    }
    
    private func configureUI() {
        [titleLabel, taskCountLabel, dummyView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            taskCountLabel.widthAnchor.constraint(equalTo: taskCountLabel.heightAnchor)
        ])
        
        dummyView.setContentHuggingPriority(.init(1), for: .horizontal)
    }
}
