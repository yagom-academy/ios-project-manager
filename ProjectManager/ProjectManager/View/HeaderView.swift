//
//  HeaderView.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/15.
//

import UIKit

final class HeaderView: UIView {
    var title: String?
    var count: Int?
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .systemBackground
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    var countLabel = CountLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect = .zero, title: String, count: Int) {
        self.init(frame: frame)
        self.title = title
        self.count = count

        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureStackView()
        configureTitleLabel()
        configureCountLabel()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
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
                                               multiplier: LayoutConstant.countLabelSizeRatio),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }
    
    enum LayoutConstant {
        static let countLabelSizeRatio = CGFloat(0.8)
    }
}
