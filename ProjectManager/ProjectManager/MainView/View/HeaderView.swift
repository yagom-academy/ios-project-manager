//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    
    let titleLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    let badgeLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.backgroundColor = .black
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(badgeLabel)
        stackView.addArrangedSubview(UIView())
        self.addSubview(stackView)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
