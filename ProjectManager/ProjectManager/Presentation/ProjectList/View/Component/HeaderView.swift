//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Private Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let countLabel: CircleCountLabel = {
        let label = CircleCountLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Interface
extension HeaderView {
    func configure(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
}

// MARK: - Configure UI
extension HeaderView {
    private func configureUI() {
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        [titleLabel, countLabel].forEach {
            addSubview($0)
        }
    }
    
    private func configureLayout() {
        let safe = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            countLabel.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -12),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor, multiplier: 1)
        ])
    }
}
