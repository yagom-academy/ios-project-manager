//
//  ListHeader.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import UIKit

final class ListHeader: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "TODO"
        
        return label
    }()
    
    private var contentAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "3"
        label.textColor = .white
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 20
        
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
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
extension ListHeader {
    private func configureUI() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, contentAmountLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        addSubview(contentStackView)
    }
    
    private func setUpConstraints() {
        setUpContentAmountLabelConstraints()
        setUpContentStackViewConstraints()
    }
    
    private func setUpContentAmountLabelConstraints() {
        contentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentAmountLabel.widthAnchor
                .constraint(equalTo: contentAmountLabel.heightAnchor, multiplier: 1)
        ])
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 8),
            contentStackView.topAnchor
                .constraint(equalTo: topAnchor, constant: 8),
            contentStackView.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
