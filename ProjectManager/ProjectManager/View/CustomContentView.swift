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
            configureContents(using: configuration)
        }
    }
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: LayoutConstant.margin,
                                                                 leading: LayoutConstant.margin,
                                                                 bottom: LayoutConstant.margin,
                                                                 trailing: LayoutConstant.margin)
        stack.layer.borderWidth = LayoutConstant.borderWidth
        stack.layer.borderColor = UIColor.systemGray.cgColor
        stack.layer.cornerRadius = LayoutConstant.cornerRadius
        
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = LayoutConstant.maxBodyLineCount
        
        return label
    }()
    
    private let dueDateLabel = UILabel()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        configureViews()
        configureContents(using: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: LayoutConstant.margin,
                                                           leading: LayoutConstant.margin,
                                                           bottom: LayoutConstant.margin,
                                                           trailing: LayoutConstant.margin)
        configureStackView()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        
        [titleLabel, bodyLabel, dueDateLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func configureContents(using configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CustomContentConfiguration,
              let deadline = configuration.deadline else { return }
        
        titleLabel.text = configuration.title
        bodyLabel.text = configuration.body
        dueDateLabel.text = DateFormatterManager().formatDate(deadline)
                
        if configuration.status != .done,
           deadline.isOverdue {
            dueDateLabel.textColor = .systemRed
        }
    }

    enum LayoutConstant {
        static let margin = CGFloat(8)
        static let borderWidth = CGFloat(1)
        static let cornerRadius = CGFloat(8)
        static let maxBodyLineCount = 3
    }
}
