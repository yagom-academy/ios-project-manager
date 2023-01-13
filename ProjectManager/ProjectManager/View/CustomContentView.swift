//
//  CustomContentView.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

class CustomContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let dueDateLabel = UILabel()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureStackView()
        configure(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CustomContentConfiguration else { return }
        
        titleLabel.text = configuration.title
        bodyLabel.text = configuration.title
        dueDateLabel.text = configuration.dueDate?.description // DateFormatter 리팩토링
    }
    
    private func configureStackView() {
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        [titleLabel, bodyLabel, dueDateLabel].forEach { stackView.addArrangedSubview($0) }
    }
}
