//
//  ProjectManager - HeaderView.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    let identifier = "HeaderView"
    
    private lazy var numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 24) {
        didSet(currentWidthAnchor) {
            currentWidthAnchor.isActive = false
            numberLabelWidthAnchor.isActive = true
        }
    }
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        configureView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(status: Status, number: String) {
        statusLabel.text = status.title
        numberLabel.text = number
        
        configureWidthAnchorConstraint(text: number)
    }
    
    private func configureUI() {
        backgroundColor = .systemGray6
    }
    
    private func configureView() {
        addSubview(statusLabel)
        addSubview(numberLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 8),
            numberLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureWidthAnchorConstraint(text: String) {
        switch text.count {
        case 2:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 30)
        case 3:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 36)
        default:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 24)
        }
    }
}
