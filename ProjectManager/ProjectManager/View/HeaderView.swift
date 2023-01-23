//
//  HeaderView.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/15.
//

import UIKit

final class HeaderView: UIView {
    private enum Constant {
        enum LayoutConstant {
            static let countLabelSizeRatio = CGFloat(0.8)
            static let margin = CGFloat(8)
        }
    }
    
    private var title: String?
    private var count: Int?
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .systemBackground
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private var countLabel = CountLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect = .zero, title: String, count: Int) {
        self.init(frame: frame)
        self.title = title
        self.count = count
        configureViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: .zero,
                                                           leading: Constant.LayoutConstant.margin,
                                                           bottom: .zero,
                                                           trailing: Constant.LayoutConstant.margin)
        configureStackView()
        configureTitleLabel()
        configureCountLabel()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = title
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func configureCountLabel() {
        countLabel = CountLabel(count: count ?? .zero)
        stackView.addArrangedSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor,
                                               multiplier: Constant.LayoutConstant.countLabelSizeRatio),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }
}
