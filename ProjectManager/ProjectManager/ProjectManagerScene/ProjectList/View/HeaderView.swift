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
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
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
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}
