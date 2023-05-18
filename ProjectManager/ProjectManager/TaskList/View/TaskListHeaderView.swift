//
//  TaskListHeaderView.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

import UIKit

class TaskListHeaderView: UIView {
    private let label = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderTitle(_ title: String) {
        label.text = title
    }
    
    private func setupStackView() {
        stackView.backgroundColor = .systemGray6
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 20, bottom: 12, right: 20)
        stackView.addArrangedSubview(label)
        
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}
