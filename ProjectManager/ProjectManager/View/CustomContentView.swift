//
//  CustomContentView.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

final class CustomContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            configure(using: configuration)
        }
    }
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: LayoutConstants.stackViewMargin,
                                                                 leading: LayoutConstants.stackViewMargin,
                                                                 bottom: LayoutConstants.stackViewMargin,
                                                                 trailing: LayoutConstants.stackViewMargin)
        stack.layer.borderWidth = LayoutConstants.borderWidth
        stack.layer.borderColor = UIColor.systemGray.cgColor
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = LayoutConstants.maxBodyLineCount
        return label
    }()
    
    
    let dueDateLabel = UILabel()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureStackView()
        configure(using: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(using configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CustomContentConfiguration else { return }
        
        titleLabel.text = configuration.title
        bodyLabel.text = configuration.body
        dueDateLabel.text = DateFormatterManager().formatDate(configuration.dueDate)
        
        if configuration.status != .done,
           configuration.dueDate ?? Date() < Date() {
            dueDateLabel.textColor = .systemRed
        }
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
    
    enum LayoutConstants {
        static let stackViewMargin = CGFloat(8)
        static let borderWidth = CGFloat(1)
        static let cornerRadius = CGFloat(8)
        static let maxBodyLineCount = 3
    }
}
