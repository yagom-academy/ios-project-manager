//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Private Property
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
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

// MARK: - Configure UI
extension HeaderView {
    private func configureUI() {
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureView() {
        self.addSubview(stackView)
    }
    
    private func configureStackView() {
        [titleLabel, countLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        let safe = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8)
        ])
    }
}
